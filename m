Subject: Re: First argument of matchpathcon_filespec_add
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, russell@coker.com.au,
        Yuichi Nakamura <ynakam@gwu.edu>, selinux@tycho.nsa.gov
In-Reply-To: <1164813040.23019.147.camel@moss-spartans.epoch.ncsc.mil>
References: <ddeda73453a4.456d4b0b@gwu.edu>
	 <200611291923.30237.russell@coker.com.au>  <456D799E.40105@kaigai.gr.jp>
	 <1164813040.23019.147.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 15:15:37 -0500
Message-Id: <1164831337.2794.149.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-29 at 10:10 -0500, Stephen Smalley wrote:
> I agree that it is a problem with the interface.  We could attempt to
> address it in a similar manner to stat() handling, but the interface is
> likely to become obsolete once the new label lookup interfaces being
> proposed by Eamon Walsh are adopted and setfiles is converted over to
> using them.

That's correct, the new interface will not take the mode but instead a
security class, such as chr_file, blk_file, etc.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
