Message-ID: <36282A1733C57546BE392885C06185924D9422@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Karl MacMillan <kmacmillan@tresys.com>,
   Chad Hanson
	 <chanson@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Frank Mayer <mayerf@tresys.com>,
   Darrel Goeddel <DGoeddel@TrustedCS.com>,
   SELinux List
	 <SELinux@tycho.nsa.gov>
Subject: RE: dynamic context transitions
Date: Wed, 3 Nov 2004 13:00:50 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Karl MacMillan wrote:
> 
> I think there are very important differences between the dynamic
> transitions and the exec model and I read part of your message above as
> arguing they are basically equivalent. Correct me if I am wrong. 

I would agree these models are not same. 

Privilege bracketing can be used for two distinct purposes. 

	The first purpose is to always run with the mininum amount of
permission to complete an operation. This model has no gain in security
assurance than program always running with all of the permissions. It can
only help audit the internal functionality of the program.
	The second purpose can permanently remove permissions from a
process. This provides a mechanism this is more strict than the previous
domain, and cannot revert back to the old domain. This is similiar to the
exec model without the environment cleansing and controlled interfaces. I
believe it could help strengthen the exec model, by disallowing usage of
helpers which are no longer needed inside an application. 

The exec model also leads itself to easier analysis as a source audit is not
needed to help determine the abilities of an application.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
