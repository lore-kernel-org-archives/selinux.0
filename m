Date: Thu, 24 Oct 2002 11:53:04 +0200
From: Tom <tom@lemuria.org>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: apache 2 patch
Message-ID: <20021024115304.A31446@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch fixes the apache policy so that apache 2 works fine
in enforcing mode.

However, I am very unhappy with the read/write permissions on the
sysadm terminals. Here are some ideas I had to fix that, and I'd like
to hear comments on them:

a) try to fix the problem in the apache source.

b) write a wrapper that relabels the current (active) pts/tty and allow
   permission to that label only
   
c) write a wrapper that fuddles with the terminals.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Description: apache2.diff
Content-Disposition: attachment; filename=x

*** default/domains/program/apache.te	Thu Oct 17 01:24:36 2002
--- current/domains/program/apache.te	Thu Oct 24 13:38:23 2002
***************
*** 367,380 ****
  
  ########################################
  # When the admin starts the server, the server wants to acess
! # the TTY or PTY associated with the session. The httpd appears
! # to run correctly without this permission, so the permission
! # are commented out here. If you decide that access is needed,
! # then uncomment, but be aware that this will grant httpd access
! # to all sysadm_r TTYs and PTYs.
  ##################################################
! allow httpd_t admin_tty_type:chr_file write;
! dontaudit httpd_t admin_tty_type:chr_file { read write };
  
  ###########################
  # Allow httpd to receive messages from the network card
--- 367,381 ----
  
  ########################################
  # When the admin starts the server, the server wants to acess
! # the TTY or PTY associated with the session. This is very bad
! # behaviour as it allows the server access to the sysadm_r TTYs
! # and PTYs, but apache2 doesn't work without.
! # If you run apache 1.x.x, try disabling this. For apache2,
! # this is currently the only solution.
  ##################################################
! allow httpd_t admin_tty_type:chr_file { read write };
! allow httpd_t sysadm_devpts_t:chr_file { read write };
! 
  
  ###########################
  # Allow httpd to receive messages from the network card
***************
*** 401,406 ****
--- 402,408 ----
  ###################################################
  allow httpd_t httpd_config_t:file r_file_perms;
  allow httpd_t httpd_config_t:dir r_dir_perms;
+ allow httpd_t httpd_config_t:lnk_file r_file_perms;
  # allow logrotate to read the config files for restart
  ifdef(`logrotate.te', `
  r_dir_file(logrotate_t, httpd_config_t)

--d6Gm4EdcadzBjdND--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
