Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s2LJnrFF025047
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 15:49:53 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so2192585eek.11
 for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2014 12:49:50 -0700 (PDT)
Received: from siphos.be ([109.132.57.87])
 by mx.google.com with ESMTPSA id u46sm13771074eel.1.2014.03.21.12.49.48
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
 Fri, 21 Mar 2014 12:49:49 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Fri, 21 Mar 2014 20:47:41 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: The sepol_set_policydb method - to be used or not?
Message-ID: <20140321194741.GA11638@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi all

In libsepol-2.2, I notice that the sepol_set_policydb() method is defined as
"hidden", so I assume it is not meant to be used outside libsepol. That
seems to be confirmed by nm:

$ nm -D /lib64/libsepol.so.1 | grep sepol_set_policydb
000000000002b8f0 T sepol_set_policydb_from_file

However, in libselinux-2.2.2 there is still reference to sepol_set_policydb():

src/audit2why.c : __policy_init():
  sepol_set_policydb(&avc->policydb->p);

Should this still be happening?

We got a bug of a user that got the following stacktrace every time
audit2why is imported through Python:

# semanage
Traceback (most recent call last):
  File "/usr/lib/python-exec/python2.7/semanage", line 27, in <module>
    import seobject
  File "/usr/lib64/python2.7/site-packages/seobject.py", line 27, in <module>
    import sepolicy
  File "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 11, in <module>
    import sepolgen.interfaces as interfaces
  File "/usr/lib64/python2.7/site-packages/sepolgen/interfaces.py", line 24, in <module>
    import access
  File "/usr/lib64/python2.7/site-packages/sepolgen/access.py", line 35, in <module>
    from selinux import audit2why
ImportError: /usr/lib64/python2.7/site-packages/selinux/audit2why.so: undefined symbol: sepol_set_policydb

Wkr,
	Sven Vermeulen

PS I need to clean my workstation up; I have the same packages/versions set
   and I don't have the issue (yet), assuming the above is indeed wrong.
