Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u14LWTon014864
 for <selinux@tycho.nsa.gov>; Thu, 4 Feb 2016 16:32:30 -0500
Received: from wheezy.localnet (ns-local [10.10.10.1])
 by smtp.sws.net.au (Postfix) with ESMTP id D7C33ED59
 for <selinux@tycho.nsa.gov>; Fri,  5 Feb 2016 08:32:21 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: selinux_set_callback() problem
Date: Fri, 5 Feb 2016 08:32:20 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201602050832.20068.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

type=USER_AVC msg=audit(1454447396.743:48359): pid=1 uid=0 auid=4294967295 
ses=4294967295 subj=system_u:system_r:init_t:s0 msg='avc:  denied  { status } 
for auid=0 uid=0 gid=0 path="/lib/systemd/system/reboot.target" 
cmdline="reboot" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:systemd_unit_file_t:SystemLow tclass=service  
exe="/lib/systemd/systemd" sauid=0 hostname=? addr=? terminal=?'

I'm seeing entries like the above from the Debian/Jessie systemd in audit.log.  
Below is the relevant code from the systemd source:

_printf_(2, 3) static int log_callback(int type, const char *fmt, ...) {
        va_list ap;

#ifdef HAVE_AUDIT
        if (get_audit_fd() >= 0) {
                _cleanup_free_ char *buf = NULL;
                int r;

                va_start(ap, fmt);
                r = vasprintf(&buf, fmt, ap);
                va_end(ap);

                if (r >= 0) {
                        audit_log_user_avc_message(get_audit_fd(), 
AUDIT_USER_AVC, buf, 
NULL, NULL, NULL, 0);
                        return 0;
                }
        }
#endif

        va_start(ap, fmt);
        log_metav(LOG_USER | LOG_INFO, __FILE__, __LINE__, __FUNCTION__, fmt, 
ap);
        va_end(ap);

        return 0;
}

Then the following line is in the access_init() function to enable it:

selinux_set_callback(SELINUX_CB_LOG, (union selinux_callback) log_callback);

Any suggestions as to where I should start working on this?

Sorry if it's a newbie question, I haven't worked on SE Linux library code for 
a while.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
