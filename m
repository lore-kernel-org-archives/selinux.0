Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rAPKDjww017665
	for <selinux@tycho.nsa.gov>; Mon, 25 Nov 2013 15:13:45 -0500
Received: by mail-bk0-f50.google.com with SMTP id e11so2228827bkh.9
        for <selinux@tycho.nsa.gov>; Mon, 25 Nov 2013 12:13:42 -0800 (PST)
Received: from siphos.be (ip-83-101-67-57.customer.schedom-europe.net. [83.101.67.57])
        by mx.google.com with ESMTPSA id on10sm48009901bkb.13.2013.11.25.12.13.40
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:13:41 -0800 (PST)
Date: Mon, 25 Nov 2013 21:12:39 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: MLS required even when MLS is disabled?
Message-ID: <20131125201239.GA24780@siphos.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all

I have a report that mentions that the new userspace release does not like
non-MLS policies:

# semanage fcontext -a -t swapfile_t "/swapfile"
libsepol.context_from_record: MLS is disabled, but MLS context "s0" found (No such file or directory).
libsepol.context_from_record: could not create context structure (Invalid argument).
libsemanage.validate_handler: invalid context system_u:object_r:swapfile_t:s0 specified for /swapfile [all files] (Invalid argument).
libsemanage.dbase_llist_iterate: could not iterate over records (Invalid argument).
OSError: Invalid argument

# semanage login -a -s staff_u amade            
libsemanage.validate_handler: MLS is disabled, but MLS range s0 was found for Unix user amade (No such file or directory).
libsemanage.validate_handler: seuser mapping [amade -> (staff_u, s0)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such file or directory).
OSError: No such file or directory

Any idea what could be the cause of this?

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
