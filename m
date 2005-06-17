Date: Fri, 17 Jun 2005 19:43:16 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Brandon Pollet <brandon@utulsa.edu>
cc: SELinux@tycho.nsa.gov, Brandon Pollet <bpollet@gmail.com>,
   John Hale <john-hale@utulsa.edu>
Subject: Re: SELinux Integrated Logging Tool
In-Reply-To: <90B34285-A36F-46C2-8081-3408F4241E6C@utulsa.edu>
Message-ID: <Xine.LNX.4.44.0506171940550.4557-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 17 Jun 2005, Brandon Pollet wrote:

> This project was developed by Nicholas Davis and it is titled  
> "Improving the Logging Facility in Security Enhanced Linux." The  
> abstract for this paper and a link to a PDF version of it appear  
> below. Please post any feedback or questions you may have. Thank you

This looks potentially useful for general syslogd management, but I'm not 
sure how it's SELinux specific. 

Also, SELinux now makes more use of the audit subsystem and auditd is the 
preferred mechanism for SELinux logging.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
