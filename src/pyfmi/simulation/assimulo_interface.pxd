#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright (C) 2020 Modelon AB
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

"""
This file contains code for mapping FMUs to the Problem specifications
required by Assimulo.
"""
import logging

import numpy as N
cimport numpy as N
from pyfmi.fmi cimport FMUModelME2

try:
    import assimulo
    assimulo_present = True
except:
    logging.warning(
        'Could not load Assimulo module. Check pyfmi.check_packages()')
    assimulo_present = False

from assimulo.problem cimport cExplicit_Problem

cdef class FMIODE2(cExplicit_Problem):
    cdef public int _f_nbr, _g_nbr, _input_activated, _extra_f_nbr, jac_nnz, input_len_names
    cdef public object _model, problem_name, result_file_name, __input, _A, debug_file_name, debug_file_object
    cdef public object export, _sparse_representation, _with_jacobian, _logging, _write_header
    cdef public dict timings
    cdef public N.ndarray y0
    cdef public list input_names, input_real_value_refs, input_real_mask, input_other, input_other_mask, _logg_step_event
    cdef public double t0
    cdef public jac_use, state_events_use, time_events_use
    cdef public FMUModelME2 model_me2
    cdef public int model_me2_instance
    cdef public N.ndarray _state_temp_1, _event_temp_1