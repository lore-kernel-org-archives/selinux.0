Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4EBGWMd003562
 for <selinux@tycho.nsa.gov>; Sun, 14 May 2017 07:16:32 -0400
Reply-To: dwalsh@redhat.com
Subject: Re: Why does Python want to read /proc/meminfo
To: Ian Pilcher <arequipeno@gmail.com>, python-list@python.org
Cc: selinux <selinux@tycho.nsa.gov>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
From: Daniel Walsh <dwalsh@redhat.com>
Message-ID: <01a5831c-a17a-c5ca-06d0-a664634819e6@redhat.com>
Date: Sun, 14 May 2017 07:16:24 -0400
MIME-Version: 1.0
In-Reply-To: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/06/2017 12:54 AM, Ian Pilcher wrote:
> I am trying to write an SELinux policy to confine a simple service that
> I have written in Python, and I'm trying to decide whether to allow or
> dontaudit various denials.
>
> To start, I've reduced my service to the simplest case:
>
>   #!/usr/bin/python
>
>   import sys
>
>   sys.exit()
>
> Running this program in a confined domain generated the following
> denial:
>
> avc:  denied  { read } for  pid=2024 comm="denatc" name="meminfo" 
> dev="proc" ino=4026532028 scontext=system_u:system_r:denatc_t:s0 
> tcontext=system_u:object_r:proc_t:s0 tclass=file
>
> The program does continue on and exit cleanly, so it doesn't seem to
> strictly require the access.
>
> Does anyone know why Python is trying to access this file, or what
> functionality I might be missing if I don't allow the access?
>
Usually tools read /proc/meminfo to figure out how much memory is 
available on the system and then to make some assumption about how much 
memory they can use.  A tool might allocate a memory buffer as X% of 
total memory on the system. (This is a bad assumption, since cgroups 
could alter the total amount of memory availabel to the process, but 
/proc/meminfo does not reflect the amount of memory available in the 
cgroup).  The code that looks at /proc/meminfo might be builtin to 
libc,  I would figure that whatever is trying to read /proc/meminfo 
expects to fail in certain situations, so it falls back to an alternate 
code path. This is most likely what you are seeing.


In most situations reading /proc/meminfo would not be considered a 
security risk, especially considering in the case of Cgroups the kernel 
will LIE.  :^)
