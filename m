Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA20691
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 10:58:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h08FwdI23226
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 15:58:39 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-smtp.csoconline.com [140.169.2.146])
        by jazzband.ncsc.mil  with SMTP id h08FwZf23222 for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 15:58:36 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015244A8@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, guttman@mitre.org,
        "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: Policy Language
Date: Wed, 8 Jan 2003 09:54:11 -0600 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, January 06, 2003 11:52 AM Stephen D. Smalley  wrote:

>> On Mon 1/6/2003 11:06 AM Joshua D. Guttman wrote:
>> Twiddles to the syntax would cause bad feeling for people who have
>> already developed policy analysis tools, or have crafted their own
>> policies.

That why I am posting to the list to try and get a feel from the
people who have created the tools. The changes so far only effect
three files. 

security_classes
initial_sids
rbac

Where security_classes and initial_sids don't change very much,
while rbac only changes on the creations of new roles. The 
general policy writer will hardly notice the change. 

>> 
>> I see that you know how to do the parsing for the language as it
>> currently exists, so please just do what's necessary...

"kludges" ?

>
>Yes, I agree.


The problem I am having in trying to build a policy management
system. The current te language and compiler build the policy.xx
from a policy.conf file. While the language work great with a 
policy.conf it will not check a te file named.te for example 
(ignoring the macros for this example)
  
I would like to eventuality move to a database system that could 
track many selinux policies for different systems. Such that the 
system could look at inputs from different te files and
import then and build policy.conf files for different systems. 

Taking the CLASS rules for example. While the current
definition work great on the policy.conf if does not work 
well on fragments of a policy.conf or a te file that is used
to build the policy.conf.

...
class_def      :  CLASS identifier
...
av_perms_def   :  CLASS identifier '{' identifier_list '}'
               |  CLASS identifier INHERITS identifier
               |  CLASS identifier INHERITS identifier '{' identifier_list
'}'
...

What I need to do when parsing a te file.
The class_def creates a key on identifier and the av_perms_def references a 
a key created by class_def. This way order can be maintain with the
class_def
processing. By adding extra definitions backwards compatibility can be build
into
the language(i.e 

class_def      :  CLASS identifier
               |  CLASSDEF identifier


I am asking to remove context sensitive meaning from tokens in the language.

Taken from "info bison".

"The Bison paradigm is to parse tokens first, then group them into
larger syntactic units.  In many languages, the meaning of a token is
affected by its context.  Although this violates the Bison paradigm,
certain techniques (known as "kludges") may enable you to write Bison
parsers for such languages."

Mark



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
