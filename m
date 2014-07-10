Message-ID: <53BEA900.2030009@tresys.com>
Date: Thu, 10 Jul 2014 10:53:52 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com> <53BE9C53.8020509@tycho.nsa.gov>
In-Reply-To: <53BE9C53.8020509@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 09:59 AM, Stephen Smalley wrote:
> 
> valgrind memcheck reports some issues:
> # valgrind --leak-check=full setsebool -P httpd_can_network_connect=1
> ==10089== Memcheck, a memory error detector
> ==10089== Copyright (C) 2002-2013, and GNU GPL'd, by Julian Seward et al.
> ==10089== Using Valgrind-3.9.0 and LibVEX; rerun with -h for copyright info
> ==10089== Command: setsebool -P httpd_can_network_connect=1
> ==10089==
> ==10089== Conditional jump or move depends on uninitialised value(s)
> ==10089==    at 0x511F50A: semanage_compile_hll (direct_api.c:937)
> ==10089==    by 0x511FD97: semanage_direct_commit (direct_api.c:1071)
> ==10089==    by 0x512DF59: semanage_commit (handle.c:426)
> ==10089==    by 0x4019C2: semanage_set_boolean_list (setsebool.c:206)
> ==10089==    by 0x401C48: setbool (setsebool.c:271)
> ==10089==    by 0x40161A: main (setsebool.c:94)
> ==10089==
> (still running, may be more...)
> 

This issue has been fixed and squashed/pushed into the integration
branch. We were missing a variable initiation, which affected cases
where no HLL modules needed to be compiled (i.e. all modules had been
previously compiled and cached).

Thanks,
- Steve
