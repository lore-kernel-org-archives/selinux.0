Date: Sun, 24 Aug 2003 23:49:06 +1000 (EST)
From: James Morris <jmorris@redhat.com>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: questions
In-Reply-To: <1061676714.1648.281.camel@kusturica>
Message-ID: <Mutt.LNX.4.44.0308242341320.21690-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 24 Aug 2003, Magosányi Árpád wrote:

> - Is polyinstantiation is put back to selinux yet? Having moldy
>  directories based on subject domain would be nice. If not, what
>  workarounds exist?

There is no polyinstantiation (of e.g. directories, ports), and AFAIK,
never has been.

> - What about networking? I see that there is nodecon and portcom,
>  and someone has written that some networking functionality is
>  out because of rejection of the corresponding LSM hooks. Do
>  they work?

Some of the missing networking functionality is in the process of being 
redesigned and added back in.

> Do we have an iptables context match module?

Not that I know of.

>  Will we?

It is possible, if someone cares to do it.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
