Subject: Re: Java and SE Linux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mark <elihusmails@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <9f066ee90707060646m2f628ca4u9b1c0da759cfffad@mail.gmail.com>
References: <9f066ee90707060646m2f628ca4u9b1c0da759cfffad@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 09 Jul 2007 10:11:53 -0400
Message-Id: <1183990313.12430.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-07-06 at 09:46 -0400, Mark wrote:
> I am interested in running some Java application in SE Linux.  I want
> to know if I can use the same JRE for java programs running under
> different SE policies?  

You should be able to use runcon to run the java program in the desired
domain, once you have defined policy appropriately for the program.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
