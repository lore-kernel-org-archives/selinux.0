Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1Q9H75S004243
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2011 04:17:07 -0500
Received: from c-sl428.itechfrontiers.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1Q9H6JI008774
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2011 09:17:06 GMT
Message-ID: <4D68C507.6090606@itechfrontiers.com>
Date: Sat, 26 Feb 2011 04:16:55 -0500
From: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
MIME-Version: 1.0
To: Ethan Heidrick <ethanheidrick@gmail.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: RIP: 0010:[<ffffffff811bdec1>] [<ffffffff811bdec1>] avc_audit_post_callback+0xc6/0xfe
References: <AANLkTi=UYvBV9piRpUapcf+6gFyJpOg8yAxt0NG9J_Re@mail.gmail.com>	<1298642860.13368.15.camel@moss-pluto>	<01F4E579-2929-4CB0-B994-1C325DE9E6F7@gmail.com> <AANLkTi=tPBYGsnRmEvsh0PibGMQ_GZ7ZE3rnEFuA6SKs@mail.gmail.com>
In-Reply-To: <AANLkTi=tPBYGsnRmEvsh0PibGMQ_GZ7ZE3rnEFuA6SKs@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ethan,

For a list of Objects Classes you can assign and work with in SELinux 
please refer to this page:

http://selinuxproject.org/page/ObjectClassesPerms

It all comes down to how you tag Video Over IP, in example using  udp_socket

Best,

Patrick K.

On 2/25/2011 10:51 PM, Ethan Heidrick wrote:
> Hello,
>
> I have a similar question concerning the considerations of applying the
> debug patch after implementing SeLinux policies, where return object
> classes become invalid when applying tagging to TV data modulation over
> IP or more specifically over [selected] cables.  The modulation exchange
> seems to be creating a buffer value that is not readable on the /sys
> level and in structuring bypasses the SeLinux implementation.  Is there
> options regarding defining these values in policies being conducted?
>
> thanks
> ethan
>
> On Fri, Feb 25, 2011 at 9:18 AM, Justin Mattock <justinmattock@gmail.com
> <mailto:justinmattock@gmail.com>> wrote:
>
>
>     On Feb 25, 2011, at 6:07 AM, Stephen Smalley wrote:
>
>         On Thu, 2011-02-24 at 12:57 -0800, Justin Mattock wrote:
>
>             this just popped up..:
>
>
>             [29804.908327] SELinux:  Invalid class 3588
>             [29804.908438] ------------[ cut here ]------------
>             [29804.908443] kernel BUG at security/selinux/avc.c:162!
>
>
>         It might help debugging to get as much of the AVC message as we
>         can even
>         in this case, e.g.
>
>
>     cool, thanks for the debug patch... I applied it, and will run it to
>     see if this fires off..
>     current kernel is: 2.6.38-rc6-00116-g2821f46
>
>
>
>         diff --git a/security/selinux/avc.c b/security/selinux/avc.c
>         index 9da6420..8c0ad28 100644
>         --- a/security/selinux/avc.c
>         +++ b/security/selinux/avc.c
>         @@ -111,6 +111,11 @@ static void avc_dump_av(struct audit_buffer
>         *ab, u16 tclass, u32 av)
>                         return;
>                 }
>
>         +       if (tclass >= ARRAY_SIZE(secclass_map)) {
>         +               audit_log_format(ab, " 0x%x", av);
>         +               return;
>         +       }
>         +
>                 perms = secclass_map[tclass-1].perms;
>
>                 audit_log_format(ab, " {");
>         @@ -159,8 +164,10 @@ static void avc_dump_query(struct
>         audit_buffer *ab, u32 ssid, u32 tsid, u16 tcla
>                         kfree(scontext);
>                 }
>
>         -       BUG_ON(tclass >= ARRAY_SIZE(secclass_map));
>         -       audit_log_format(ab, " tclass=%s",
>         secclass_map[tclass-1].name);
>         +       if (tclass < ARRAY_SIZE(secclass_map))
>         +         audit_log_format(ab, " tclass=%s",
>         secclass_map[tclass-1].name);
>         +       else
>         +         audit_log_format(ab, " tclass=%d", tclass);
>         }
>
>         /**
>
>
>         --
>         Stephen Smalley
>         National Security Agency
>
>
>
>     Justin P. Mattock
>
>
>
>
>     --
>     This message was distributed to subscribers of the selinux mailing list.
>     If you no longer wish to subscribe, send mail to
>     majordomo@tycho.nsa.gov <mailto:majordomo@tycho.nsa.gov> with
>     the words "unsubscribe selinux" without quotes as the message.
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
