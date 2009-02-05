Subject: Re: problem with capabilities inheritance and auditing in python
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40902050908n5391c4b4l417714fe87a47f29@mail.gmail.com>
References: <cadfc0e40902050908n5391c4b4l417714fe87a47f29@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 13:10:36 -0500
Message-Id: <1233857436.3181.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-05 at 11:08 -0600, Xavier Toth wrote:
> I've set the capabilities on a script that runs some python code with
> auditing calls in it but I'm not getting audit records written to the
> audit log. From what I've read I thought the +i would all the
> capability to be inherited across execve but this doesn't appear to be
> the case. Can anyone help me understand what's going wrong here? Is
> there a way in the python code to get the capabilities to see if
> indeed cap_audit_write was inherited?

Linux doesn't honor setuid on scripts, and file capabilities are
supposed to have the same behavior (they didn't for a while due to an
oversight, but that was corrected).  You need an executable wrapper
program that invokes the script, like:
http://oss.tresys.com/projects/clip/browser/trunk/RHEL5.2/scripts/wrappers/wrapper.c

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
