Message-ID: <4A4B9FA8.1040606@redhat.com>
Date: Wed, 01 Jul 2009 13:40:56 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Christopher Pardy <cpardy@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit settings]
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com> <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------040403070209040907000901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040403070209040907000901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 07/01/2009 01:04 PM, Stephen Smalley wrote:
> On Wed, 2009-07-01 at 11:57 -0400, Daniel J Walsh wrote:
>> On 07/01/2009 09:32 AM, Christopher Pardy wrote:
>>> Creates a empty file disable_dontaudit in the polciy directory
>>> (/etc/selinux/<policytype>). Checks for the existance of this file to
>>> set the sepol disable don't audit upon handle creation. Also provides
>>> the function "int semanage_get_disable_dontaudit()" which returns the
>>> don't audit property of the current policy.
>>>
>>> Signed-off-by: Christopher Pardy<cpardy@redhat.com>
>> Better version of patch.
>
> How does one then re-enable dontaudit rules using semodule or semanage?
>
> We've trained our users to do the following sequence:
> 	semodule -DB
> 	<trigger AVC denials>
> 	semodule -B
>
> With the patch, the latter step will not re-enable dontaudit rules
> unless you also change semodule, right?
>
Patch for semodule command

semodule -B

Will now turn on dontaudit rules

semodule -DB

Will turn off dontaudit rules.

With other patch all other semanage commands will maintain state.



--------------040403070209040907000901
Content-Type: text/plain;
 name="policycoreutils-dontaudit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-dontaudit.patch"

diff -up policycoreutils-2.0.64/semodule/semodule.c~ policycoreutils-2.0.64/semodule/semodule.c
--- policycoreutils-2.0.64/semodule/semodule.c~	2009-06-23 15:36:25.000000000 -0400
+++ policycoreutils-2.0.64/semodule/semodule.c	2009-07-01 13:34:42.027229000 -0400
@@ -417,8 +418,10 @@ int main(int argc, char *argv[])
 			printf("Committing changes:\n");
 		if (no_reload)
 			semanage_set_reload(sh, 0);
-		if (build)
+		if (build) {
+			semanage_set_disable_dontaudit(sh, 0);
 			semanage_set_rebuild(sh, 1);
+		}
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
 		result = semanage_commit(sh);

--------------040403070209040907000901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
