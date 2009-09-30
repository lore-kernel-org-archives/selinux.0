Message-ID: <4AC2C9DF.2010402@ak.jp.nec.com>
Date: Wed, 30 Sep 2009 12:00:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil> <1254250342.2252.203.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1254250342.2252.203.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> One other note:  before we can allow arbitrary ordering of class
> definitions, we need to update all userspace object managers to use
> selinux_set_mapping().  This includes cronie,  usermode, pam, mcstrans,
> passwd, shadow-utils, util-linux-ng, nscd (glibc), dbus and possibly
> others I am forgetting.  Also libselinux rpm_execcon().

busybox. It uses checkPasswdAccess() which internally calls
string_to_security_class() but requested access vector is
delivered without any translation.

#if ENABLE_SELINUX
static void check_selinux_update_passwd(const char *username)
{
        security_context_t context;
        char *seuser;

        if (getuid() != (uid_t)0 || is_selinux_enabled() == 0)
                return;         /* No need to check */

        if (getprevcon_raw(&context) < 0)
                bb_perror_msg_and_die("getprevcon failed");
        seuser = strtok(context, ":");
        if (!seuser)
                bb_error_msg_and_die("invalid context '%s'", context);
        if (strcmp(seuser, username) != 0) {
                if (checkPasswdAccess(PASSWD__PASSWD) != 0)
                        bb_error_msg_and_die("SELinux: access denied");
        }
        if (ENABLE_FEATURE_CLEAN_UP)
                freecon(context);
}
#else
#define check_selinux_update_passwd(username) ((void)0)
#endif

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
