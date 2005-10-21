Subject: Re: [ SEPOL ] Reorganize users.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4357F76A.7040009@cornell.edu>
References: <4357F5DF.30905@cornell.edu>  <4357F76A.7040009@cornell.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 10:09:16 -0400
Message-Id: <1129903756.27663.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 16:00 -0400, Ivan Gyurdiev wrote:
> > - makes is_valid/exists function update a parameter, rather than 
> > mixing response and return status code
> Oops...forgot to initialize status in the success path. Corrected patch 
> attach (gets rid of the variable).

Merged as of libsepol 1.9.24 and libsemanage 1.3.31.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
