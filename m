Subject: Re: are comments allowed in default_contexts?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Larry Ross <selinux.larry@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <81092d891001250839s7b864f2o4343564b2d17b34c@mail.gmail.com>
References: <81092d891001250839s7b864f2o4343564b2d17b34c@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 25 Jan 2010 12:47:03 -0500
Message-Id: <1264441623.4297.184.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-01-25 at 08:39 -0800, Larry Ross wrote:
> A quick question: Are comments allowed in the default_contexts and
> user contexts files?
>  
> /etc/selinux/strict/contexts/
> and  
> /etc/selinux/strict/contexts/users/root
>  
> Are normal '#' comment lines ignored in the processing of these files?

Technically, no.  However, the first field (e.g. system_r:crond_t:s0) is
matched against the caller's context and if it does not match, then the
line is ignored.  So in effect, any illegal context value, including '#'
should cause the entire line to be ignored.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
