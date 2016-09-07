Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u87AYTU0004638
 for <selinux@tycho.nsa.gov>; Wed, 7 Sep 2016 06:34:29 -0400
Received: from process-dkim-sign-daemon.mr25p46im-ztdg02111301.me.com by
 mr25p46im-ztdg02111301.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0OD400600QHYAD00@mr25p46im-ztdg02111301.me.com> for selinux@tycho.nsa.gov;
 Wed, 07 Sep 2016 10:34:08 +0000 (GMT)
Content-type: text/plain; charset=us-ascii
From: ileyd <ileyd@icloud.com>
MIME-version: 1.0 (1.0)
Subject: Re: SELinux MLS Policies
Date: Wed, 07 Sep 2016 20:19:36 +1000
Message-id: <F2AB24C8-E99E-45B2-9C58-B9312BD26CB9@icloud.com>
References: <"01e601d202e0$7aaf62d0$700e2870$@a.bolton"@m0noc.net>
 <dcfa502a-a210-2815-33a7-825d905e4be6@tycho.nsa.gov>
 <612965bc-952f-9f95-ca14-7c8a8c6e7b6e@m0noc.net>
 <9D586F02-4DA2-450A-9E31-541A97D554BE@icloud.com>
 <d63bb241-6166-57cc-475b-131f509fafbf@m0noc.net>
 <64786c70-3f89-4bc1-fdc8-fa0897784e58@redhat.com>
Cc: Paul Bolton <paul.a.bolton@m0noc.net>, selinux@tycho.nsa.gov
In-reply-to: <64786c70-3f89-4bc1-fdc8-fa0897784e58@redhat.com>
To: Petr Lautrbach <plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


> On 7 Sep 2016, at 7:03 PM, Petr Lautrbach <plautrba@redhat.com> wrote:
> 
>> On 08/31/2016 09:53 AM, Paul Bolton wrote:
>> 
>> 
>>> On 31/08/16 07:37, ileyd wrote:
>>> 
>>> Have you managed to correct the incorrect labelling of /etc?  When I've tried to use the MLS policy on RHEL/CentOS 7-7.2, that has stopped logins from working when running in enforcing mode.
>> 
>> So if I turn off the dontaudit rules that issue shows up with
>> unix_chkpwd and mls_constrain AVCs. Admittedly I did notice it was at
>> s15 but thought that was intentional. Though, as most of the files in
>> /etc are at s0 that doesn't sound right.
>> 
>> Anyway, changing /etc to s0 allows logins to work; and looks more like
>> what I would expect an out-of-the-box MLS system to look like.
>> 
>> Thanks for the advice.
> 
> This is a bug in initscripts.
> 
> /usr/lib/systemd/rhel-import-state copies files from initrd to a
> filesystem during boot but doesn't reset level on the copied files.
> Since dracut is running as ks15, copied files  inherits s15 level. The
> fix is quite easy:
> 
> --- /usr/lib/systemd/rhel-import-state.bug      2016-09-07
> 04:44:45.413231227 -0400
> +++ /usr/lib/systemd/rhel-import-state  2016-09-07 04:44:51.645274588 -0400
> @@ -7,5 +7,5 @@
> 
> # run restorecon on the copied files
> if [ -e /sys/fs/selinux/enforce -a -x /usr/sbin/restorecon ]; then
> -    find . -mindepth 1 -print0 | { cd / && xargs --null restorecon -i; }
> +    find . -mindepth 1 -print0 | { cd / && xargs --null restorecon -i -F; }
> fi
> 
> 
> Petr
> -- 
> Petr Lautrbach
> 
> 
Thanks for sharing that!
