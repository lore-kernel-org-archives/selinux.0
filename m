Cc: SE-Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Message-Id: <01F4E579-2929-4CB0-B994-1C325DE9E6F7@gmail.com>
From: Justin Mattock <justinmattock@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <1298642860.13368.15.camel@moss-pluto>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: RIP: 0010:[<ffffffff811bdec1>] [<ffffffff811bdec1>] avc_audit_post_callback+0xc6/0xfe
Date: Fri, 25 Feb 2011 09:18:13 -0800
References: <AANLkTi=UYvBV9piRpUapcf+6gFyJpOg8yAxt0NG9J_Re@mail.gmail.com> <1298642860.13368.15.camel@moss-pluto>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 25, 2011, at 6:07 AM, Stephen Smalley wrote:

> On Thu, 2011-02-24 at 12:57 -0800, Justin Mattock wrote:
>> this just popped up..:
>>
>>
>> [29804.908327] SELinux:  Invalid class 3588
>> [29804.908438] ------------[ cut here ]------------
>> [29804.908443] kernel BUG at security/selinux/avc.c:162!
>
> It might help debugging to get as much of the AVC message as we can  
> even
> in this case, e.g.

cool, thanks for the debug patch... I applied it, and will run it to  
see if this fires off..
current kernel is: 2.6.38-rc6-00116-g2821f46

>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9da6420..8c0ad28 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -111,6 +111,11 @@ static void avc_dump_av(struct audit_buffer  
> *ab, u16 tclass, u32 av)
> 		return;
> 	}
>
> +	if (tclass >= ARRAY_SIZE(secclass_map)) {
> +		audit_log_format(ab, " 0x%x", av);
> +		return;
> +	}
> +
> 	perms = secclass_map[tclass-1].perms;
>
> 	audit_log_format(ab, " {");
> @@ -159,8 +164,10 @@ static void avc_dump_query(struct audit_buffer  
> *ab, u32 ssid, u32 tsid, u16 tcla
> 		kfree(scontext);
> 	}
>
> -	BUG_ON(tclass >= ARRAY_SIZE(secclass_map));
> -	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> +	if (tclass < ARRAY_SIZE(secclass_map))
> +	  audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> +	else
> +	  audit_log_format(ab, " tclass=%d", tclass);
> }
>
> /**
>
>
> -- 
> Stephen Smalley
> National Security Agency


Justin P. Mattock



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
