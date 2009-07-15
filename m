MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: /etc/selinux/  directory structure...
Date: Wed, 15 Jul 2009 12:09:32 -0400
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D06F02F2C@de01exm68.ds.mot.com>
In-Reply-To: <1247673423.9960.10.camel@notebook2.grift.internal>
References: <D06FE0A2807BC145B0D38744789D4F5D06817A56@de01exm68.ds.mot.com> <13D6E9E0302C0E4B9EE667132D21766C02B8342F@ala-mail09.corp.ad.wrs.com> <D06FE0A2807BC145B0D38744789D4F5D06F02EC0@de01exm68.ds.mot.com> <1247673423.9960.10.camel@notebook2.grift.internal>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Dominick Grift" <domg472@gmail.com>
Cc: <selinux@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Interesting.  Thanks so much for your response.

Is there some place I can get more useful info about how best to take my
current set of 'strict' policies, and sort of migrate them onto the new
improved targeted policy framework.

I am not dying to use 'strict' policies... The reasons why I was pushed
in this direction were:
- I wrote some policies (custom.pp) to deny certain accesses by certain
users. The targeted policy didn't seem to be restricting those
operations, as I had intended. But the strict policy, did.
- I wanted the philosophy of, "when in doubt, block the operation", as
opposed to "when in doubt, allow the operation".  I felt that the
'strict' policy better aligns with that goal. Perhaps I am wrong, and
either option is viable ?

In any case, I guess I would have to develop my policies again to fit
with the targeted policy framework now. Any suggestions on a good
starting point.. Documentation, training materials for developing custom
policies ?   Thanks again for the help.


-----Original Message-----
From: Dominick Grift [mailto:domg472@gmail.com] 
Sent: Wednesday, July 15, 2009 10:57 AM
To: Hasan Rezaul-CHR010
Cc: selinux@tycho.nsa.gov; Daniel J Walsh; Stephen Smalley
Subject: Re: /etc/selinux/ directory structure...

On Wed, 2009-07-15 at 11:25 -0400, Hasan Rezaul-CHR010 wrote:
> Hi All,
> 
> I work on a product that uses Linux Kernel 2.6.21.  We are currently 
> using the following SELinux libs and related package
> versions:
> 
> checkpolicy      1.33.1
> libselinux       2.0.13
> libsemanage      2.0.1
> libsepol         2.0.3
> libsetrans       0.1.18
> policycoreutils  2.0.16
> 
> I am implementing the "Strict" policy. And so I see the directory 
> structure on my machine as:
> 
> -------------------------------------------
> /etc/selinux/config
> /etc/selinux/restorecond.conf
> /etc/selinux/semanage.conf
> 
> /etc/selinux/strict/
> /etc/selinux/strict/contexts/
> /etc/selinux/strict/modules/
> /etc/selinux/strict/policy/
> /etc/selinux/strict/setrans.conf
> /etc/selinux/strict/seusers
> 
> --------------------------------------------
> 
> 
> We are moving to a newer Linux version 2.6.27 (that's packaged for us 
> by a third-party company), and as a result of this newer OS delivery, 
> we will automatically get moved to the SELinux package version:
> 
> checkpolicy      svn2950
> libselinux       svn2950
> libsemanage      svn2950
> libsepol         svn2950
> libsetrans       N/A
> policycoreutils  svn2950
> 
> 
> ** My questions are:
> 
> 1. I see the  /etc/selinux/   directory structure is quite different
for
> the svn2950 version!  Is it supposed to be that way ?
> 
> 2. Is the difference in directory structure due to the svn2950 package

> version, or is it because of a newer Linux kernel version ? (Linux
> 2.6.21  vs.  Linux 2.6.27)
> 
> 3. Is the 'strict' policy supported in this svn2950 version?
> 
> 4. In the LATEST officially released version(s) of the Selinux 
> packages from http://userspace.selinuxproject.org/trac/wiki/Releases, 
> is the /etc/selinux/  directory structure the same as I have described
in the
> ---  block  ---   above, or did it change ?
> 
> 5. Does the LATEST officially supported versions still support
"strict"
> policy, or does it only support "targeted" ??

It supports "strict policy" but the strict policy model merged with the
targeted policy model. You would have to configure the Targeted SELinux
policy to make it strict.

> 
> 6. Has the concept of "targeted" policy changed since about two years 
> ago ?

Not really. Targeted policy still targets a set of processes and the
rest goes into the unconfined domain. However, now it is possible to
uninstall the unconfined module which effectively turns your targeted
policy into a strict policy. 

Basically the targeted policy was extended by the merger with strict
policy.

> Thanks in advance for all your help.
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
