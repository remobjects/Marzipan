<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003" DefaultTargets="Build" ToolsVersion="4.0">
    <PropertyGroup>
        <RootNamespace>RemObjects.Marzipan</RootNamespace>
        <ProjectGuid>b8a8b4bb-61d3-49b0-bafe-99016e5b3225</ProjectGuid>
        <OutputType>StaticLibrary</OutputType>
        <AssemblyName>Marzipan</AssemblyName>
        <AllowGlobals>True</AllowGlobals>
        <AllowLegacyWith>False</AllowLegacyWith>
        <AllowLegacyOutParams>False</AllowLegacyOutParams>
        <AllowLegacyCreate>False</AllowLegacyCreate>
        <AllowUnsafeCode>False</AllowUnsafeCode>
        <Configuration Condition="'$(Configuration)' == ''">Release</Configuration>
        <SDK>OS X</SDK>
        <CreateHeaderFile>True</CreateHeaderFile>
        <Name>RemObjects.Marzipan</Name>
        <BundleIdentifier>com.remObjects.marzipan</BundleIdentifier>
    </PropertyGroup>
    <PropertyGroup Condition=" '$(Configuration)' == 'Debug' ">
        <Optimize>false</Optimize>
        <OutputPath>.\bin\Debug</OutputPath>
        <DefineConstants>DEBUG;TRACE;</DefineConstants>
        <GenerateDebugInfo>True</GenerateDebugInfo>
        <EnableAsserts>True</EnableAsserts>
        <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
        <CaptureConsoleOutput>False</CaptureConsoleOutput>
        <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
    </PropertyGroup>
    <PropertyGroup Condition=" '$(Configuration)' == 'Release' ">
        <Optimize>true</Optimize>
        <OutputPath>.\bin\Release</OutputPath>
        <GenerateDebugInfo>False</GenerateDebugInfo>
        <EnableAsserts>False</EnableAsserts>
        <TreatWarningsAsErrors>False</TreatWarningsAsErrors>
        <CaptureConsoleOutput>False</CaptureConsoleOutput>
        <WarnOnCaseMismatch>True</WarnOnCaseMismatch>
    </PropertyGroup>
    <ItemGroup>
        <Reference Include="CoreGraphics"/>
        <Reference Include="Foundation"/>
        <Reference Include="libmono-2.0">
            <HintPath>libmono-2.0\OS X\libmono-2.0.fx</HintPath>
        </Reference>
        <Reference Include="rtl"/>
        <Reference Include="libNougat"/>
    </ItemGroup>
    <ItemGroup>
        <Compile Include="Library.pas"/>
        <Compile Include="MonoRuntime.pas"/>
    </ItemGroup>
    <ItemGroup>
        <Folder Include="Properties\"/>
    </ItemGroup>
    <Import Project="$(MSBuildExtensionsPath)/RemObjects Software/Oxygene/RemObjects.Oxygene.Nougat.targets"/>
    <PropertyGroup>
        <PreBuildEvent/>
    </PropertyGroup>
</Project>