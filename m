Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5CFfCwe004920
 for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2014 11:41:12 -0400
Message-ID: <5399CA69.7070901@tresys.com>
Date: Thu, 12 Jun 2014 11:42:33 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, Sven Vermeulen
 <sven.vermeulen@siphos.be>, selinux <selinux@tycho.nsa.gov>
Subject: Re: SETools patch for libselinux-2.3
References: <20140528170411.GA13025@siphos.be>	<53965DC4.1090802@tresys.com>
 <CAJfZ7==jjeVo-g82L9=VOv92QF6=akK+5e+-VVmsf+wdvWR-yQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==jjeVo-g82L9=VOv92QF6=akK+5e+-VVmsf+wdvWR-yQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/11/2014 06:26 PM, Nicolas Iooss wrote:
> 2014-06-10 3:22 GMT+02:00 Christopher J. PeBenito <cpebenito@tresys.com>:
>> On 5/28/2014 1:04 PM, Sven Vermeulen wrote:
>>> Index: secmds/replcon.cc
>>> ===================================================================
>>> --- secmds/replcon.cc (revision 4973)
>>> +++ secmds/replcon.cc (working copy)
>>> @@ -60,7 +60,7 @@
>>>       {NULL, 0, NULL, 0}
>>>  };
>>>
>>> -extern int lsetfilecon_raw(const char *, security_context_t) __attribute__ ((weak));
>>> +extern int lsetfilecon_raw(const char *, const char *) __attribute__ ((weak));
>>
>> Unfortunately, this breaks it in the same way if you compile with libselinux < 2.3 with this patch.  The preference would be a patch that allows it to compile with any recent libselinux, rather than requiring libselinux 2.3.
> 
> When compiling SETools on ArchLinux I got this error message from gcc
> (version 4.9.0):
> 
> replcon.cc:73:25: error: invalid operands of types '<unresolved
> overloaded function type>' and 'long int' to binary 'operator!='
>     if (lsetfilecon_raw != NULL)
> 
> I've never used weak functions in C libraries so I don't know the
> proper fix to support libselinux versions which don't provide
> lsetfilecon_raw, but as in ArchLinux only the most recent stable
> version of packages is supported, I simply removed all the code
> related to the "weak function trick" to make it works [1]. According
> to git log, lsetfilecon_raw existed in 2008 [2]. Is it possible to
> replace replcon_lsetfilecon with lsetfilecon_raw in SETools or are
> there still supported versions of libselinux without lsetfilecon_raw?

Well a weak function just means that the program won't fail to link if lsetfilecon_raw() isn't found.  It's the method we used to support older libselinuxes when the _raw() functions appeared.  I'm not sure if there is a proper C/C++ way to handle the apparent parameter change, otherwise preprocessor #ifdef/#else would be the way.  So if you do #ifdef SECURITY_CONTEXT_T it uses the old version #else it uses the new version, then autoconf would determine if SECURITY_CONTEXT_T needs to be set.  Alternatively it might work to conditionally re-add the security_context_t typedef inside this file.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
