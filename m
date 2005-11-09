Message-ID: <43715253.2070108@cmcrc.com>
Date: Wed, 09 Nov 2005 12:35:15 +1100
From: Johan Fischer <jfischer@cmcrc.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: [refpolicy][PATCH] fix Makefile BASE_MODS and MOD_MODS detection
Content-Type: multipart/mixed;
 boundary="------------060609020703070904060801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060609020703070904060801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

quick patch to fix the modules detection from the modules.conf file...

before:
$ awk '/^[[:blank:]]*[[:alpha:]]/{ if ($3 == "module") print $1 }'
policy/modules.conf
(no result)

after:
$ awk '/^[[:blank:]]*[[:alpha:]]*/{ if ($3 == "module") print $1 }'
policy/modules.conf
apm
apache
bluetooth

Cheers.
J.


-- 
Johan Fischer
Capital Markets CRC Limited
Level 2, 9 Castlereagh Street, Sydney NSW 2000
Tel: +61 2 9233 7999   Direct: +61 2 9236 9150
Fax: +61 2 9236 9177   http://www.cmcrc.com

Capital Markets CRC Ltd (CMCRC) - Confidential Communication
The information contained in this e-mail is confidential.  It is intended solely for the addressee. If you receive this e-mail by mistake please promptly inform us by reply e-mail and then delete the e-mail and destroy any printed copy. You must not disclose or use in any way the information in the e-mail. There is no warranty that this e-mail is error or virus free. It may be a private communication, and if so, does not represent the views of the CMCRC and its associates. If it is a private communication, care should be taken in opening it to ensure that undue offence is not given.


--------------060609020703070904060801
Content-Type: text/plain;
 name="Makefile.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile.diff"

? Makefile.diff
Index: Makefile
===================================================================
RCS file: /cvsroot/serefpolicy/refpolicy/Makefile,v
retrieving revision 1.24
diff -u -r1.24 Makefile
--- Makefile	7 Nov 2005 20:10:44 -0000	1.24
+++ Makefile	9 Nov 2005 01:31:06 -0000
@@ -199,8 +199,8 @@
 MODMOD := module
 
 # extract settings from modules.conf
-BASE_MODS := $(foreach mod,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null),$(subst ./,,$(shell find -iname $(mod).te)))
-MOD_MODS := $(foreach mod,$(shell awk '/^[[:blank:]]*[[:alpha:]]/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null),$(subst ./,,$(shell find -iname $(mod).te)))
+BASE_MODS := $(foreach mod,$(shell awk '/^[[:blank:]]*[[:alpha:]]*/{ if ($$3 == "$(MODBASE)") print $$1 }' $(MOD_CONF) 2> /dev/null),$(subst ./,,$(shell find -iname $(mod).te)))
+MOD_MODS := $(foreach mod,$(shell awk '/^[[:blank:]]*[[:alpha:]]*/{ if ($$3 == "$(MODMOD)") print $$1 }' $(MOD_CONF) 2> /dev/null),$(subst ./,,$(shell find -iname $(mod).te)))
 
 HOMEDIR_TEMPLATE = tmp/homedir_template
 

--------------060609020703070904060801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
