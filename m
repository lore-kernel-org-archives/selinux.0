Subject: Re: [SEMANAGE] Further bugfixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <200601210139.53555.russell@coker.com.au>
References: <43D0383C.8010404@cornell.edu> <43D0D8E2.2020304@cornell.edu>
	 <43D0EDA1.5070002@redhat.com>  <200601210139.53555.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 10:28:13 -0500
Message-Id: <1137770893.3648.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-01-21 at 01:39 +1100, Russell Coker wrote:
> On Saturday 21 January 2006 01:03, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > -R "user_r sysadm_t secadm_r"
> >
> > works or at least should work.
> 
> The attached patch does everything my last patch does but also adds support 
> for multiple -R options.
> 
> A more sensible (IMHO) and more script-friendly way of doing this is to 
> support -R user_r -R sysadm_r -R secadm_r.  Naturally my patch doesn't break 
> the existing functionality, just allows doing it either way.

Merged along with Ivan's patch.  They conflicted on the usage changes,
but I went with Russell's version for now, as they synchronized with the
man page.  Feel free to suggest further modifications (e.g. file_spec
isn't very clear, but neither was context_expression).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
