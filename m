Message-ID: <1346084367.9950.10.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: neverallow and attributes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Date: Mon, 27 Aug 2012 12:19:27 -0400
In-Reply-To: <20120827143758.GC2168@telvanni>
References: <20120827143758.GC2168@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-08-27 at 16:37 +0200, Ole Kliemann wrote:
> If I do:
> 
>     attribute A;
>     
>     type T1_t;
>     type T2_t;
>     
>     typeattribute T2_t A;
>     
>     allow A T1_t:file read;
>     
>     neverallow T2_t T1_t:file read;
> 
> I can compile and load the corresponding module. I can even do:
> 
>     allow A T1_t:file read;
>     
>     neverallow A T1_t:file read;
> 
> without problems.
> 
> I cannot do:
> 
>     allow T2_t T1_t:file read;
>     
>     neverallow A T1_t:file read;
> 
> 
> The neverallow assertion does not find any allows that are 
> constituted by allowing something for an attribute.
> 
> Is this normal behaviour?

I would call that a bug.  However, I'm not surprised, as Fedora disables
the neverallow checking by default (expand-check=0
in /etc/selinux/semanage.conf), so it doesn't get much testing these
days.  Possibly the neverallow checking has never been updated to
account for preservation of attributes in the kernel policy (originally
all attributes were expanded at compile-time).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
