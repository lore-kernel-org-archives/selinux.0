Message-ID: <3FCE05F9.8090006@uncc.edu>
Date: Wed, 03 Dec 2003 16:49:13 +0100
From: Dhruv Gami <dgami@uncc.edu>
MIME-Version: 1.0
To: SELINUX <SELinux@tycho.nsa.gov>
Subject: Basic question on policy design
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Everyone,

I am trying to understand how  Type Enforcement has been implemented in 
SELinux, and am using the sample policy given with the SELinux packages 
as an example.

In the paper "Meeting Critical Security Objectives with SELinux", 
Stephen Smalley and Peter Loscocco say:

The TE Configuration file defines an extensible set of types. Using the 
allow statement, allowable permissions between pairs of types are 
specified for each object class.

allow type_1 type_2:class { perm_1 ... perm_n };

The meaning of this above rule is not too clear to me.
1. what exactly is the relationship between type_1 and type_2 ?
2. is the class associated with type_2 only ?
3. Are type_1 and type_2 interchangable in the above rule ?
4. is there any rule that type_1 should be subject and type_2 should be 
an object type ?

The structure of the policy rules is not very clear to me. Is there any 
documentation available which makes it clear ? maybe im missing 
something somewhere. any help in this regard would be greatly appreciated.

regards,
Dhruv Gami


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
