Message-ID: <42399AE4.5040508@kaigai.gr.jp>
Date: Thu, 17 Mar 2005 23:57:40 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp>	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>	 <4235C937.3030404@kaigai.gr.jp>	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>	 <4236CC03.5010104@kaigai.gr.jp>	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>	 <4237B950.2090604@ak.jp.nec.com>	 <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>	 <42394ECA.7010204@ak.jp.nec.com> <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

>>e.g.
>>attribute attr;
>>type X;
>>type Y extends attr;
>>type Z extends Y;
>>
>>"allow @attr foo:XXX XXX;" means "allow Y foo:XXX XXX;", Z is not included.
>
>
> Ah, the fact that Y is included is interesting; this is due to the fact
> that your implementation handles 'type Y extends attr;' in the same
> manner as a 'type Y, attr;' declaration, right?

Yes, this EXTENDS syntax does not discriminate type with attribute.
There is no reason for dealing with those discriminatory, I think.


>>Effective use of existing software assets is reason.
>>For example, samba_httpd_content_t is a type extends samba_share_t
>>and httpd_sys_content_t.  When we try to use the union filetype
>>"samba_httpd_content_t", we must fix the allow statements of "samba_share_t"
>>and "httpd_sys_content_t" if an allow statement without '@' means
>>no-expandable permission grant.
>
>
> True, and you also have to track down all indirect references, e.g. uses
> of "file_type" or "sysadmfile" in the policy.

Hmm,,,
Indeed, difficulty for validation has possibility to become complex problem.
OK, I'll implement EXTENDS patch with no-expansion by default and "@type" means
expand descendants.
I try to optimize that existing policy will be made EXTENDS syntax conscious.
Please wait new patch for a while.

Thanks
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
