Subject: Re: [ SEMANAGE ] Fix hidden declarations
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1131628976.19626.15.camel@moss-spartans.epoch.ncsc.mil>
References: <43728384.3020508@cornell.edu>
	 <1131628976.19626.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 08:43:31 -0500
Message-Id: <1131630211.19626.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-10 at 08:22 -0500, Stephen Smalley wrote:
> > This patch:
> > 
> > - removes the hidden proto for sepol_user_exists(), and 
> > sepol_seuser_iterate(), which make those functions invisible (no 
> > hidden_def, not sure if one should be added).
> 
> No, this re-introduces relocations on those symbols (actually semanage_,
> not sepol_).  Correct fix is to add hidden_defs for these symbols, not
> to remove the hidden_protos.  If you had run relinfo.pl (attached) on
> the .so file after applying your patch, you would have seen that it
> yielded relocations on local syms.  Or you could just run readelf -r on
> the .so file and grep for semanage_ prefix.
> 
> > - changes two cases of hidden_proto in iface_record.c to hidden_def, 
> > because that just looks wrong.
> 
> Yes, that was a bug.

Merged with the above issue corrected.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
