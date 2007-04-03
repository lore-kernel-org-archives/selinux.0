Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l33E112E026319
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 10:01:01 -0400
Received: from web86915.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l33E0u4M010261
	for <selinux@tycho.nsa.gov>; Tue, 3 Apr 2007 14:00:56 GMT
Message-ID: <20070403140044.77116.qmail@web86915.mail.ukl.yahoo.com>
Date: Tue, 3 Apr 2007 14:00:44 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Identification of Attribute values within the Security Server
To: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Every one,


1) Can constraint(s) be specified in the "RefPolicy" e.g. is this Refpolicy is correct:

policy_module(local, 1.0)  

require {
         type unconfined_t;
         type fs_t priv_type;
}

type x_t;
bool test true;

allow x_t fs_t:filesystem associate;
if (test) {
         # allow unconfined_t all access to x_t
         allow unconfined_t x_t:dir *;
         allow unconfined_t x_t:file *;
} else {
         # allow unconfined_t only ls access
         allow unconfined_t x_t:dir { getattr read search };
         allow unconfined_t x_t:file {getattr }; 
}
constrain filesystem associate (t1=priv_type)

The intended semantics of this policy is to associate an attribute with the fs_t typeand then further constrain the permissions. But the above semantics can be achieved by (t1=t2) may be?.


2) SELinux policy may contain attributes, which can be associated with types and can be checked within the constrain(t) expressions in a further step. Within the security server i.e. ss/services.c however, the function "constraint_expr_eval" checks the types only and there is no check for delcared attribute seperately i think so. It seems that attributes are internally mapped to types and within the "constraint_expr_eval" function, only types are checked? Secondly, integers are associated with these types. Whether these types are mapped to integers seperately some where else?. Actually, my intension is to identify a particular type within the "constraint_expr_eval" but i found that, types are first mapped to integers first, and not directly machted based on their names. Is this a correct approach for the identification of particular types or a better approach can be taken before entering into the security server?


Thanks,
Best
JG


        
___________________________________________________________ 
Yahoo! Messenger - with free PC-PC calling and photo sharing. http://uk.messenger.yahoo.com


		
___________________________________________________________ 
Inbox full of unwanted email? Get leading protection and 1GB storage with All New Yahoo! Mail. http://uk.docs.yahoo.com/nowyoucan.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
