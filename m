Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA4M14xo009193
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2013 17:01:04 -0500
Received: by mail-ea0-f180.google.com with SMTP id l9so3123951eaj.11
        for <selinux@tycho.nsa.gov>; Mon, 04 Nov 2013 14:01:02 -0800 (PST)
Received: from siphos.be ([193.244.33.62])
        by mx.google.com with ESMTPSA id s3sm51838243eeo.3.2013.11.04.14.00.54
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Nov 2013 14:01:00 -0800 (PST)
Date: Mon, 4 Nov 2013 23:00:23 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: No module named policycoreutils.default_encoding_utf8 ?
Message-ID: <20131104220022.GA6511@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

In policycoreutils-2.2.1/semanage/semanage, the first import is:

"""
import policycoreutils.default_encoding_utf8
"""

On my system (Python 2.7) this fails with:

Traceback (most recent call last):
  File "/usr/sbin/semanage-python2.7", line 26, in <module>
    import policycoreutils.default_encoding_utf8
ImportError: No module named policycoreutils.default_encoding_utf8

Is this specific for a particular Python version?

I commented it out and most other things work just fine (I only have a small
issue with audit2allow not wanting to generate refpolicy-style modules even
though the interface_info file is - I think - up2date and is being read by
audit2allow).

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
