Subject: Re: [ SEMANAGE ] Replace semanage debugging system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <434BD7DE.3080206@cornell.edu>
References: <434B62B8.4080309@cornell.edu>
	 <1129037671.3308.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1129039592.3308.110.camel@moss-spartans.epoch.ncsc.mil>
	 <434BCC58.7030509@cornell.edu>
	 <1129041009.3308.125.camel@moss-spartans.epoch.ncsc.mil>
	 <434BD2CB.8050007@cornell.edu>
	 <1129042012.3308.139.camel@moss-spartans.epoch.ncsc.mil>
	 <434BD7DE.3080206@cornell.edu>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 11:19:03 -0400
Message-Id: <1129043943.3308.162.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-11 at 11:18 -0400, Ivan Gyurdiev wrote:
> > Why not just use the handle directly, and drop the separate message
> > structure entirely?
> >   
> It's disorganized... the handle contains all kinds of things - I don't 
> like adding random fields to it. It'd be more orderly to add a 
> structure, and functions to work with it, in a separate file. I would 
> think that nested structs have no runtime overhead...

Hmmm...well, I thought that one of the purposes of the handle was for
error handling, and you are adding the callback and callback arg there
in place of the old error buffer.  More generally, I was wondering if
the callback might want the handle without needing to explicitly specify
it as part of the callback arg.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
