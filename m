Message-ID: <3F30FC1E.8030709@tresys.com>
Date: Wed, 06 Aug 2003 09:01:18 -0400
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: Diyab <diyab@diyab.net>
Cc: SELinux@tycho.nsa.gov
Subject: Re: attribute definitions
References: <3F2FD7E9.6010207@diyab.net>
In-Reply-To: <3F2FD7E9.6010207@diyab.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Diyab wrote:

> Where are the type attributes defined?  I'm trying to find out what 
> these attributes give permissions to but I can not find any reference 
> to where they are defined.  I've tried grepping the policy for things 
> like sysadmfile but all I can find is the use of the attribute, not a 
> definition.
>
> Timothy,
>
You can use our analysis tool, apol, to determine the set of types that 
use an attribute or which attributes are assigned to a specific type. 
You can also do regular expression searches on either types or 
attributes and display the appropriate groupings.  The tool is included 
in the SE Linux distribution and available from our web site, 
http://www.tresys.com/selinux.

David

David Caplan
dac@tresys.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
