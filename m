Message-ID: <4346A667.6020005@cornell.edu>
Date: Fri, 07 Oct 2005 12:46:31 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu>	 <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil>	 <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil>	 <434699D7.9040307@cornell.edu>	 <1128700907.1450.50.camel@moss-spartans.epoch.ncsc.mil> <1128701153.1450.54.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128701153.1450.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you're changing the shared API, this might be a good time to 
introduce a handle object: sepol_handle_t, and pass it as an argument to 
the shared functions. It could contain a callback function, and the 
argument for it. You could also hide the policydb and/or policy_file in 
it, unless you prefer to keep them as a separate argument - I'm not sure 
which is better. If hidden within the handle, they could be NULL until 
initialized.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
