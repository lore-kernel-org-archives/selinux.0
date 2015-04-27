Message-ID: <553E417B.3040406@draigBrady.com>
Date: Mon, 27 Apr 2015 15:02:35 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigbrady.com>
MIME-Version: 1.0
To: Paul Eggert <eggert@cs.ucla.edu>, 20437@debbugs.gnu.org
Subject: Re: bug#20437: ls links too many dynamic libraries
References: <553DC968.80809@cs.ucla.edu> <553E35B7.3020105@draigBrady.com>
In-Reply-To: <553E35B7.3020105@draigBrady.com>
Content-Type: text/plain; charset=utf-8
Cc: SE-Linux <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 27/04/15 14:12, Pádraig Brady wrote:
> tag 20437 notabug
> close 20437
> stop
> 
> On 27/04/15 06:30, Paul Eggert wrote:
>> Currently GNU 'ls' dynamically links a whole bunch of libraries, libraries like 
>> libpcre and liblzma.  Can we figure out some way to remove the runtime 
>> dependencies on these libraries?  It's better if a core utility like 'ls' avoids 
>> libthis and libthat unless the libraries are vital to its function, which these 
>> shouldn't be.
>>
>> I installed the attached patches to get rid of one unnecessary library, libacl, 
>> on GNU/Linux.  Can we do better and get rid of more dependencies?  Perhaps using 
>> techniques similar to what was used to get rid of libacl?
> 
> As was discussed recently¹ with removing the libmount dependency for df,
> these dependencies are coming from libselinux, and one of the primary
> authors of libselinux was made aware of that issue, so I'm closing
> this here.
> 
> coreutils linking with libselinux are:
> 
>  chcon cp dir install id ls mkdir mkfifo mknod mv runcon stat vdir
> 
> BTW I noticed ldd -v doesn't give complete info,
> and that `readelf -d $(which ls) | grep NEEDED` is better.
> This is wrapped in the lddot² visualizer, and I've attached
> the output from `lddot git/coreutils/src/ls | graph-easy --as png`
> 
> cheers,
> Pádraig.
> 
> ¹ http://lists.gnu.org/archive/html/coreutils/2015-04/msg00011.html
> ² http://jwilk.net/software/lddot

BTW I had a look at whether we could duplicate some getfilecon() logic
internally, but it doesn't seem practical due to mcstransd which
is a daemon that's used to translate the MCS / MLS internal policy
levels into user friendly labels.

I.E. we could duplicate the logic, and remove the lzma and pcre dependencies,
but it seems like too much to be duplicating. Further reductions in deps
might be possible by splitting up libselinux, allowing apps like ls
that just read contexts, to link with the appropriate lib.

cheers,
Pádraig.
