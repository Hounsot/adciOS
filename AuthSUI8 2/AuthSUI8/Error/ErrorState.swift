//
//  ErrorState.swift
//  AuthSUI8
//  Created by brfsu on 07.02.2024.
//
import Foundation

enum ErrorState
{
    case Error(message: String)
    case Success(message: String)
    case None // no error state
}
