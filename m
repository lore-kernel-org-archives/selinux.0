Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3TLE4bA031009
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 17:14:04 -0400
Received: by mail-la0-f52.google.com with SMTP id mc6so591042lab.39
 for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2014 14:14:03 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 29 Apr 2014 17:14:02 -0400
Message-ID: <CACLa4pvP9mjjGvQ+SkyoorYZAAdxAHMy3maK8rmkbJRMa6JQPA@mail.gmail.com>
Subject: selinux_check_access() and unknown classes/perms
From: Eric Paris <eparis@parisplace.org>
To: SE-Linux <selinux@tycho.nsa.gov>, Dominick Grift <dominick.grift@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selinux_check_access() has code like this:

       sclass = string_to_security_class(class);
       if (sclass == 0) {
               rc = errno;
               if (security_deny_unknown() == 0)
                       return 0;
               errno = rc;
               return -1;
       }

My problem with the code is that we have no logging of any kind why we
just returned -1;  The reason this was found is because Dominick is
writing custom policy that doesn't define all of the classes/perms
used by systemd and has security_deny_unknown() == 1.  systemd calls
selinux_check_access() gets -EINVAL, prints that it denied, but no
where do we have a good reason why it was denied.  systemd doesn't
know, it's hidden in this library...

A good first step would be to call avc_log(SELINUX_ERR, ...) in the
case where we return an error.  But what do we do in the
security_deny_unknown() == 0 case?  I'd still like to call avc_log,
but only do it once rather than flood our logs.  Any suggestions how
to pull that off?

-Eric
