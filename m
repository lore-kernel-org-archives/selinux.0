Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3M8dDgd025047
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 04:39:13 -0400
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3M8dB9C003075
	for <selinux@tycho.nsa.gov>; Wed, 22 Apr 2009 08:39:12 GMT
Message-ID: <49EED77F.5060407@ak.jp.nec.com>
Date: Wed, 22 Apr 2009 17:38:23 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: dwalsh@redhat.com, method@manicmethod.com
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, russell@coker.com.au,
        SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: daemons and MCS categories
References: <200605220930.05483.russell@coker.com.au> <1148910738.14262.67.camel@sgc.columbia.tresys.com> <49EC1F11.6040003@ak.jp.nec.com> <49ED29CC.6080507@ak.jp.nec.com>
In-Reply-To: <49ED29CC.6080507@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------060403030700020708010200"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060403030700020708010200
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The attached patch is a proof-of-concept for the facility to launch
daemon processes with a certaon mcs ranges.

The selinux-daemon-mcs-run_init.patch add run_init a new option which
specifies the name of daemon.

  # run_init -n httpd /etc/init.d/httpd restart

When -n option is given, run_init lookups under the
/etc/selinux/<policy type>/contexts/initrc/<daemon>, and replaces the
range to be assigned on the init script.

  [root@saba run_init]# cat /etc/selinux/targeted/contexts/initrc/httpd
  s0-s0:c0.c31
  [root@saba run_init]# ./run_init -n httpd /etc/init.d/httpd restart
  Authenticating kaigai.
  Password:
  Stopping httpd:                                            [  OK  ]
  Starting httpd:                                            [  OK  ]
  [root@saba run_init]# ps -AZ | grep httpd
  system_u:system_r:httpd_t:s0-s0:c0.c31 11303 ? 00:00:00 httpd
  system_u:system_r:httpd_t:s0-s0:c0.c31 11305 ? 00:00:00 httpd
  system_u:system_r:httpd_t:s0-s0:c0.c31 11308 ? 00:00:00 httpd
  system_u:system_r:httpd_t:s0-s0:c0.c31 11309 ? 00:00:00 httpd
  system_u:system_r:httpd_t:s0-s0:c0.c31 11310 ? 00:00:00 httpd
     :

The selinux-daemon-mcs-rc-script.patch is a short hack to the system
init script. It launches the required script with "runcon -l", if
per-daemon range is configured.

These reworks typicall enable web-application (launched by httpd) to
perform in a certain restrictive category of MCS.
Currently, mod_selinux's security policy module assigns "mcssetcats"
on httpd_t, but it is fundamentally denger and nonsense. :(

So, I would like to see the daemon processes with appropriate categories.

Thanks,

KaiGai Kohei wrote:
> KaiGai Kohei wrote:
>> Sorry for opening the old discussion again.
>>
>> If you don't ML logs in local, please see the archives:
>>   http://marc.info/?t=114825463100001&r=1&w=2
>>
>> Christopher J. PeBenito wrote:
>>> I agree with James on this, I don't think we want to impose semantics in
>>> the MCS categories, and that this
>>>
>>>> Another possibility is to have the ability to configure which categories are 
>>>> assigned to a daemon via run_init or some similar program.  It would not be 
>>>> difficult to read a config file that maps the domain of a daemon to the range 
>>>> that should be granted to it.
>>> is useful so that if users do want to run a daemon with categories, they
>>> can.
>> Is it still unavailable on the current SELinux userspace utilities, isn't it?
> 
> Shall we start to implement an extention of run_init and others based on
> the above Russell's idea?
> 
> Now, I have a plan to store configuration files at:
>   /etc/selinux/${POLICY_TYPE}/contexts/initrc/${DAEMON}
>    or
>   /etc/selinux/${POLICY_TYPE}/contexts/initrc_contexts with format extensions
> 
> and, add a new option to run_init as:
>   run_init [-n <daemon>] <script> [<args> ...]
> 
>   It intends to see the per-daemon default range, instead of the initrc_contexts.
> 
> and, add a bit of hacks on the /etc/rc.d/rc script which launches daemon scripts
> when run-level is changed. (Maybe, it is necessary to launch them via "runcon -l"
> when the given daemon has its own range.)
> 
> The last also need to have a discussion in the Fedora developer's list.
> Dan, do you think it is a hopefull proposition?
> 
> Thanks,
> 
>> If we could start the init-scripts via runcon by hand, it seems to me the
>> daemon processes performs with multi categories.
>>
>>  | [root@saba ~]# runcon -l s0-s0:c0.c255 /etc/init.d/httpd restart
>>  | Stopping httpd:                                            [  OK  ]
>>  | Starting httpd:                                            [  OK  ]
>>  | [root@saba ~]# ps -AZ | grep httpd
>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6458 ? 00:00:00 httpd
>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6460 ? 00:00:00 httpd
>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6461 ? 00:00:00 httpd
>>  | unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 6462 ? 00:00:00 httpd
>>  |      :
>>
>> But it is unavailable when the system kicks init-script on startup time.
>> Is there any good idea?
>>
>> In the recent days, I'm working for an apache module (mod_selinux.so) which
>> launches web application handler under an individual security context based
>> on http-authentication.
>> I'm looking for the way to assign a few dozens of categories on httpd server
>> processes which are launched at system startup time.
>>
>> Thanks,
> 
> 


-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------060403030700020708010200
Content-Type: text/x-patch;
 name="selinux-daemon-mcs-run_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-daemon-mcs-run_init.patch"

diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
index 9db766c..e4442a3 100644
--- a/policycoreutils/run_init/run_init.c
+++ b/policycoreutils/run_init/run_init.c
@@ -338,12 +338,64 @@ int get_init_context(security_context_t * context)
 
 }				/* get_init_context() */
 
+/*
+ * fuxup_daemon_context()
+ *
+ * Fixup the range of CONTEXT based on per-daemon setups
+ *
+ * in:		The original CONTEXT
+ * out:		The modified CONTEXT, if necessary.
+ * return:	The modified CONTEXT, or NULL if error.
+ */
+static security_context_t
+fixup_daemon_context(security_context_t oldcon, const char *daemon)
+{
+	FILE *fp;
+	const char *whitespace = " \f\n\r\t\v";
+	char filename[PATH_MAX], buf[255];
+	security_context_t newcon = oldcon;
+
+	snprintf(filename, sizeof(filename) - 1, "%s/initrc/%s",
+		 selinux_contexts_path(), daemon);
+	fp = fopen(filename, "r");
+	if (!fp)
+		return oldcon;	/* no need to fixup */
+
+	while (1) {		/* loop until we find a non-empty line */
+		context_t context;
+		char *range;
+
+		if (!fgets(buf, sizeof(buf), fp))
+			break;
+
+		range = strtok(buf, whitespace);
+		if (!range)
+			continue;
+
+		newcon = NULL;
+		if (strtok(NULL, whitespace))
+			break;
+
+		context = context_new(oldcon);
+		if (!context)
+			break;
+
+		if (context_range_set(context, range))
+			break;
+
+		newcon = context_str(context);
+		break;
+	}
+	fclose(fp);
+	return newcon;
+}
+
 /*****************************************************************************
  * main()                                                                    *
  *****************************************************************************/
 int main(int argc, char *argv[])
 {
-
+	const char *daemon = NULL;
 	extern char *optarg;	/* used by getopt() for arg strings */
 	extern int opterr;	/* controls getopt() error messages */
 	security_context_t new_context;	/* context for the init script context  */
@@ -372,6 +424,10 @@ int main(int argc, char *argv[])
 		fprintf(stderr, "%s\n", USAGE_STRING);
 		exit(-1);
 	}
+	if (!strcmp("-n", argv[1]) && argv[2] != NULL) {
+		daemon = argv[2];
+		argv += 2;
+	}
 
 	/*
 	 * Step 2:  Authenticate the user.
@@ -388,6 +444,14 @@ int main(int argc, char *argv[])
 #ifdef CANTSPELLGDB
 		printf("context is %s\n", new_context);
 #endif
+		if (daemon) {
+			new_context = fixup_daemon_context(new_context, daemon);
+			if (!new_context)
+				exit(-1);
+#ifdef CANTSPELLGDB
+			printf("modified context is %s\n", new_context);
+#endif
+		}
 	} else {
 		exit(-1);
 	}

--------------060403030700020708010200
Content-Type: text/x-patch;
 name="selinux-daemon-mcs-rc-script.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-daemon-mcs-rc-script.patch"

--- /etc/rc.d/rc.orig	2009-04-21 09:48:27.000000000 +0900
+++ /etc/rc.d/rc	2009-04-22 17:16:57.000000000 +0900
@@ -18,6 +18,17 @@
 	return 0
 }
 
+# SELinux init range
+selinux_init_range ()
+{
+	. /etc/selinux/config
+
+	test -x /usr/sbin/selinuxenabled && /usr/sbin/selinuxenabled || return
+	test -r /etc/selinux/${SELINUXTYPE}/contexts/initrc/$1 || return
+
+	cat /etc/selinux/${SELINUXTYPE}/contexts/initrc/$1
+}
+
 # Now find out what the current and what the previous runlevel are.
 argv1="$1"
 set `/sbin/runlevel`
@@ -97,7 +108,14 @@
 		export LC_ALL=C
 		exec $i start
 	fi
-	$i start
+	# SELinux range to be launched
+	range=`selinux_init_range $subsys`
+	if [ -n "$range" -a -x /usr/bin/runcon ]; then
+		/usr/bin/runcon -l $range -- $i start
+		echo "$1 was launched as $range"
+	else
+		$i start
+	fi
 	[ -n "$UPSTART" ] && initctl emit --quiet "started $subsys"
 done
 [ "$do_confirm" = "yes" ] && rm -f /var/run/confirm

--------------060403030700020708010200--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
