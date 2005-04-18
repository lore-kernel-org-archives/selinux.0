Subject: Re: [RFC & PATCH] inherited type definition.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <4260BF6C.6030008@kaigai.gr.jp>
References: <42346C17.3090301@kaigai.gr.jp>
	 <1110808202.21378.51.camel@moss-spartans.epoch.ncsc.mil>
	 <4235C937.3030404@kaigai.gr.jp>
	 <1110824712.21378.196.camel@moss-spartans.epoch.ncsc.mil>
	 <4236CC03.5010104@kaigai.gr.jp>
	 <1110897751.25947.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4237B950.2090604@ak.jp.nec.com>
	 <1110981928.4802.81.camel@moss-spartans.epoch.ncsc.mil>
	 <42394ECA.7010204@ak.jp.nec.com>
	 <1111067742.8664.31.camel@moss-spartans.epoch.ncsc.mil>
	 <42399AE4.5040508@kaigai.gr.jp>  <423E9CFF.3080808@kaigai.gr.jp>
	 <1111420782.13101.16.camel@moss-spartans.epoch.ncsc.mil>
	 <42412635.4030108@ak.jp.nec.com>
	 <1111586217.21107.54.camel@moss-spartans.epoch.ncsc.mil>
	 <4260BF6C.6030008@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 08:25:45 -0400
Message-Id: <1113827145.28051.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-16 at 16:31 +0900, KaiGai Kohei wrote:
> How is the current status of inheritable-type patch ?
> Can I think that we can use such statements checkpolicy-1.24 or later ?
> Please, don't forget. :-)
> 
> I modified the latest patch against to checkpolicy-1.23.1 on Fedora's CVS.
> Since there is only one FAILED hunk on checkpolicy.c:518, I modified this.

Hi,

Thanks for updating the patch.  However,  from the discussions on the
list, I haven't seen any clear indication that this new language
feature:
a) solves a real problem in a superior manner to the use of macros, and
b) is being demanded by people who are presently developing policy.

I'm willing to be convinced otherwise, but I just haven't seen the
evidence for it yet.  Have you considered working on a template feature
for the language instead, as that clearly would be beneficial?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
