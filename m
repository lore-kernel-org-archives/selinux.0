Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA417rXZ020029
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 20:07:53 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA417pJZ016047
	for <selinux@tycho.nsa.gov>; Thu, 4 Nov 2004 01:07:52 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.1/8.13.1/Debian-16) with ESMTP id iA40xkZ3005651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 18:59:46 -0600
To: selinux@tycho.nsa.gov
Subject: Re: Updated SELinux Release
References: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Wed, 03 Nov 2004 18:59:46 -0600
In-Reply-To: <1099496380.1213.111.camel@moss-spartans.epoch.ncsc.mil> (Stephen
	Smalley's message of "Wed, 03 Nov 2004 10:39:40 -0500")
Message-ID: <87vfcmqvi5.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 03 Nov 2004 10:39:40 -0500, Stephen Smalley <sds@epoch.ncsc.mil> said: 

> An updated SELinux release is available from the NSA SELinux web
> site; see http://www.nsa.gov/selinux/news.cfm#R041102.  

	I have been looking at the changes in libsepol, and I see
 these changes to the API:
======================================================================
-int mls_sid_to_context(context_struct_t * context,
+int mls_sid_to_context(policydb_t *policydb,
+                      context_struct_t * context,
                       char **scontext);

-int mls_context_to_sid(char oldc,
+int mls_context_to_sid(policydb_t *policydb,
+                      char oldc,
                       char **scontext,
                       context_struct_t * context);

-int mls_compute_sid(context_struct_t *scontext,
+int mls_compute_sid(policydb_t *policydb,
+                   context_struct_t *scontext,
                    context_struct_t *tcontext,
                    security_class_t tclass,
                    uint32_t specified,

-int sens_read(policydb_t * p, hashtab_t h, void * fp);
-int cat_read(policydb_t * p, hashtab_t h, void * fp);
+int sens_read(policydb_t * p, hashtab_t h, struct policy_file *fp);
+int cat_read(policydb_t * p, hashtab_t h, struct policy_file *fp);
======================================================================

	Unfortunately, this has not been accompanied with an soname
 change, this can't be a good thing.  I would suggest bumping up the
 soname to match the version (libsepol.so.1.2), to minimize confusion.

	manoj
-- 
The existence of god implies a violation of causality.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
