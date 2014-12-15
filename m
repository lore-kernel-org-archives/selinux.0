Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBFFCWRd020003
 for <selinux@tycho.nsa.gov>; Mon, 15 Dec 2014 10:12:33 -0500
Message-ID: <548EFA51.2060505@tresys.com>
Date: Mon, 15 Dec 2014 10:12:17 -0500
From: Steve Lawrence <slawrence@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: Jason Zaman <jason@perfinion.com>, Sven Vermeulen
 <sven.vermeulen@siphos.be>
Subject: Re: ANN: SELinux Userspace Release: 20140826-rc7
References: <5480B2DB.6010408@tresys.com>
 <CAPzO=Ny_kUT2drj3KzW_uhLLpeOqxPJtOa5R46PGa5bhCT92Eg@mail.gmail.com>
 <20141214160431.GA28896@meriadoc.Home>
In-Reply-To: <20141214160431.GA28896@meriadoc.Home>
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/14/2014 11:04 AM, Jason Zaman wrote:
> On Sun, Dec 14, 2014 at 04:46:40PM +0100, Sven Vermeulen wrote:
>> On Thu, Dec 4, 2014 at 8:15 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>>> The seventh release candidate for the next release of SELinux Userspace
>>> [1] is now available. T
>> [...]
>>
>> Hi all
>>
>> Is it possible to kepe the tmp/ directory when building/loading a policy fails?
>>
>> # semodule -v -i foo.pp
>> Attempting to install module 'foo.pp':
>> Ok: return value of 0.
>> Committing changes:
>> Conflicting type rules
>> Binary policy creation failed at line 177 of
>> /var/lib/selinux/mcs/tmp/modules/400/java/cil
> 
> Alternatively, would it be possible to just print out line 177 to the
> terminal? Diving into files is less ideal than just seeing both
> conflicting lines directly in the output.
> 
> eg when there are errors during building:
> /usr/bin/checkmodule:  loading policy configuration from tmp/mycustom.tmp
> mycustom.te:55:ERROR 'unknown type stttttaff_t' at token ';' on line 2790:
> allow stttttaff_t syslogd_t:unix_dgram_socket sendto;
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> 
> 
>> Failed to generate binary
>> semodule:  Failed!
>>
>> The tmp/ directory is cleared so it is not possible to use that
>> location for troubleshooting.
>>
>> In this particular case, I could find the java/cil in the
>> /var/lib/selinux/mcs/active/modules/400 location, but if the error
>> would be within the foo.pp-generated CIL file, then the CIL file
>> cannot be found anymore.
>>

Both good suggestions. I agree that it can be difficult to track down
issues. CIL diagnostics have plenty of room for improvement.

One thing that may help, if you were not already aware, you can always
compile the pp file to CIL yourself with something like this:

$ cat /var/lib/selinux/.../hll | bunzip2 | /usr/libexec/selinux/hll/pp

It's not perfect, but should allow you to view the generated CIL and
figure out where the error is to help track things down.

With all that said, I'm not sure this a blocker, and is something we'll
target to improve in the next SELinux Userspace release.

- Steve
