Message-ID: <42653D1F.4090106@redhat.com>
Date: Tue, 19 Apr 2005 13:17:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jason <jason@tyrannical.org>
CC: SELinux@tycho.nsa.gov
Subject: Re: Problems with SElinux and MySQL accessing file on /tmp
References: <426468C8.1080102@tyrannical.org>
In-Reply-To: <426468C8.1080102@tyrannical.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jason wrote:

> I am having an error with selinux that I can't seem to fix.
>
> avc: denied { getattr } for pid=123 exe=/usr/libexec/mysqld
>
> I get that when I try to use a mysql query "load data concurrent 
> infile '/tmp/filename' etc"
>
> allow mysqld_t tmp_t:dir { getattr }; doesn't help. I need a way to 
> give mysql  getattr globally, or at least in the tmp folder.  in 
> filecontexts, /tmp/.* is listed as <<none>>
>
> the file it's accessing in /tmp is user_u:object_r:tmp_t
>
> audit2allow doesn't display anything since it's a denied { getattr } 
> without any other info.
>
> Does anyone have an idea what can be done?
>
> TIA,
>
> Jason
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

What AVC messages are you seeing in /var/log/messages or 
/var/log/audit/audit.log?

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
