Message-ID: <49DF25E5.5090307@redhat.com>
Date: Fri, 10 Apr 2009 06:56:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Problems related to the policy language
References: <1239290907.22856.57.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1239290907.22856.57.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/09/2009 11:28 AM, James Carter wrote:
> 1. Inflexibility
> 	a. Limitations to what can be in a module
> 2. Gaps in features
> 	a. User transitions
> 	b. Type inheritance
> 3. Ordering issues
> 	a. Unless the rules are in the same file, proper ordering cannot
> 	be guaranteed for portcon and other rules for which ordering is
> 	important
> 4. Confusing semantics
> 	a. Between templates and interfaces
> 	b. Between tunables and booleans
> 	c. Require rules
> 	d. Optional blocks
> 5. Inconsistencies in the syntax
> 	a. Some rules end with a semi-colon, others do not
> 	b. Some lists are space separated, some are comma separated
> 	c. Some lists require curly braces even when there is only one
> 	member, others do not
> 	d. For some rules the order of the rules matter, in others they
> 	do not
> 	e. File contexts start with the path
>
Attributes and types are not interchangeable.

Can not assign and attribute to an attribute.

Booleans can not contain booleans
Attributes can not be assigned via booleans.

Having something like:

tunable_bolicy(`unconfined_services', 	`
	unconfined_domain($1)
')

Tools do not do a good job of telling you when you have a constraint 
violation or any way to get around a constraint violation.

Need ability to easily extend objects

java/mono/execmem extensions.

user_t + execmem + execstack = user_java_t, where user_jave_t has full 
all the same access as user_t and full access between them  user_t <-> 
user_java_t.

sepolgen tool needs more formal syntax to do a better job of finding the 
best interface for an access violation.

Need tools to find out whether a domain is a permissive domain.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
