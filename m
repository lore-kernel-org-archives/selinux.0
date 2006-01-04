Message-ID: <43BBFCB2.8@cornell.edu>
Date: Wed, 04 Jan 2006 11:49:54 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
References: <43BBD6C0.6020108@cornell.edu>	 <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>	 <43BBF408.7030701@cornell.edu> <1136399098.27632.284.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1136399098.27632.284.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------060209090105020009030006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060209090105020009030006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2006-01-04 at 11:12 -0500, Ivan Gyurdiev wrote:
>   
>>> Thanks, your entire patch series has been merged as of libsepol 1.11.2,
>>> libsemanage 1.5.4, and policycoreutils 1.29.3.
>>>   
>>>       
>> Question - I did some reordering of the headers in semanageswig.i (at 
>> the beginning).
>> I see you haven't merged that part, but you're missing a header that I 
>> added - booleans_active.h (which is why I did the reordering actually - 
>> not to miss any headers). Of course, semanage.h includes all of those 
>> headers, so I'm not sure whether or not any of them are needed in the 
>> first place, given that semanage.h is included.
>>     
>
> Ah, I had some rejects on that file, and tried resolving them manually,
> but I missed that.
>   
Well, here's my current diff against that file..



--------------060209090105020009030006
Content-Type: text/x-patch;
 name="libsemanage.swig_headers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.swig_headers.diff"

diff -Naurp --exclude man --exclude-from excludes old/libsemanage/src/semanageswig.i new/libsemanage/src/semanageswig.i
--- old/libsemanage/src/semanageswig.i	2006-01-04 10:54:48.000000000 -0500
+++ new/libsemanage/src/semanageswig.i	2006-01-03 05:38:30.000000000 -0500
@@ -20,31 +20,29 @@
 
 %module semanage
 %{
-	#include "semanage/boolean_record.h"
 	#include "semanage/debug.h"
-	#include "semanage/interfaces_policy.h" 
-	#include "semanage/ports_policy.h"      
-	#include "semanage/booleans_local.h"     
-	#include "semanage/handle.h"             
-	#include "semanage/modules.h"            
-	#include "semanage/semanage.h"           
+	#include "semanage/handle.h"
+	#include "semanage/modules.h"
+	#include "semanage/context_record.h"
+	#include "semanage/boolean_record.h"
+	#include "semanage/booleans_policy.h"
+	#include "semanage/booleans_local.h"
+	#include "semanage/booleans_active.h"
+	#include "semanage/iface_record.h"
+	#include "semanage/interfaces_local.h"
+	#include "semanage/interfaces_policy.h"
 	#include "semanage/user_record.h"
-	#include "semanage/booleans_policy.h"    
-	#include "semanage/iface_record.h"       
-	#include "semanage/port_record.h"        
-	#include "semanage/seuser_record.h"
- 	#include "semanage/fcontext_record.h"
- 	#include "semanage/fcontexts_local.h"
-	#include "semanage/fcontexts_policy.h"
 	#include "semanage/users_local.h"
-	#include "semanage/context_record.h"     
-	#include "semanage/interfaces_local.h"   
-	#include "semanage/ports_local.h"        
-	#include "semanage/seusers.h"            
 	#include "semanage/users_policy.h"
 	#include "semanage/port_record.h"
 	#include "semanage/ports_local.h"
 	#include "semanage/ports_policy.h"
+	#include "semanage/seuser_record.h"
+	#include "semanage/fcontext_record.h"
+	#include "semanage/fcontexts_local.h"
+	#include "semanage/fcontexts_policy.h"
+	#include "semanage/seusers.h"	
+	#include "semanage/semanage.h"
 %}
 
 %inline {

--------------060209090105020009030006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
