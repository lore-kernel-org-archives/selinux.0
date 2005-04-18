Message-ID: <4263E701.6070009@kaigai.gr.jp>
Date: Tue, 19 Apr 2005 01:57:37 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [RFC & PATCH] inherited type definition.
References: <42346C17.3090301@kaigai.gr.jp>	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>	 <4235C937.3030404@kaigai.gr.jp>	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>	 <4236CC03.5010104@kaigai.gr.jp>	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>	 <4237B950.2090604@ak.jp.nec.com>	 <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>	 <42394ECA.7010204@ak.jp.nec.com>	 <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>	 <42399AE4.5040508@kaigai.gr.jp>  <423E9CFF.3080808@kaigai.gr.jp>	 <1111420782.13101.16.camel@moss-spartans.epoch.ncsc.mil>	 <42412635.4030108@ak.jp.nec.com>	 <1111586217.21107.54.camel@moss-spartans.epoch.ncsc.mil>	 <4260BF6C.6030008@kaigai.gr.jp> <1113827145.28051.36.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1113827145.28051.36.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello, Thanks for your comments.

> Thanks for updating the patch.  However,  from the discussions on the
> list, I haven't seen any clear indication that this new language
> feature:
> a) solves a real problem in a superior manner to the use of macros, and

One example is Samba, FTP and Apache combined type definition.
If we try to solve this requirement with existing macros only,
we have to describe the access-permit macros for each type
as I said in past days.

In addition, I intend to use domain inheritance for my original policy
configuration only, because it's strongly opposed to merge into upstream.
But it's useful for developing the application with setcon(), I think.
When we intend to execute a child process in separate domain from the parent,
there are some common permission such as shared-memory, and so on.
It's redandant to grant same permissions for each domain, even if it's
done by any macros. If parent-type is granted the common permission,
we can restrain redandancy and human-errors by duplication of configuration.

Sorry, above example is not real-world application like apache.
But I think the definition of relationship between types is
useful functionality for developing SELinux aware applications.


> b) is being demanded by people who are presently developing policy.

Since the existing policy has been written by macros yet, the quiet
requirement for type-inheritance is indeed natural.
But I think type-inheritance is useful for appropriate field
on developing new policy.
Of course, we can select using macros depending on circumstances.


> I'm willing to be convinced otherwise, but I just haven't seen the
> evidence for it yet.  Have you considered working on a template feature
> for the language instead, as that clearly would be beneficial?

In my understanding, template feature defines horizontal relationship of types.
e.g) the relationship of staff_t, staff_home_dir_t and staff_home_t.

Type inheritance defines vertical relationship of types.
e.g) the relationship of samba_share_t, ftp_anon_t and those combined type.

Those features provide another worth. Am I wrong ?

Thanks,
-- 
DO NOTHING IS THE WORST POLICY.
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
