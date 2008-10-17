Subject: Re: Protecting against inadvertent file copy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sanjai Narain <narain@research.telcordia.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <48F8B58C.9040609@research.telcordia.com>
References: <48F798BB.6070602@rubix.com>
	 <1224186793.9247.139.camel@moss-spartans.epoch.ncsc.mil>
	 <1224186905.9247.141.camel@moss-spartans.epoch.ncsc.mil>
	 <48F85ECC.108@rubix.com>
	 <1224245613.18694.26.camel@moss-spartans.epoch.ncsc.mil>
	 <48F89EBE.6020800@rubix.com>
	 <1224253435.19562.23.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8ABBC.9060808@rubix.com>
	 <1224256522.19562.54.camel@moss-spartans.epoch.ncsc.mil>
	 <48F8B58C.9040609@research.telcordia.com>
Content-Type: text/plain
Date: Fri, 17 Oct 2008 13:14:55 -0400
Message-Id: <1224263695.19562.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-17 at 11:55 -0400, Sanjai Narain wrote:
> Hello: I am just getting started with SELinux, and would very much 
> appreciate an answer to the following question:
> 
> Suppose there is a directory ftp_dir. If one wants to allow ftp of one's 
> file to the outside world, one places it in ftp_dir. Suppose there is 
> also a directory private_dir. One wants to prevent copying of any file 
> in that directory into ftp_dir. In particular, one wants to say "do not 
> allow cp from private_dir to ftp_dir". How would one go about expressing 
> this in SELinux?

By labeling the two directories with two different types, and defining
the roles/domains such that no domain can both read from private_dir and
write to ftp_dir.  If you want to be strict about it, you'd further have
to ensure that there is no path by which information from private_dir
can eventually flow to ftp_dir, e.g. by copying it first into some
shared directory and then from there to ftp_dir.  apol will show
information flow paths among types.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
