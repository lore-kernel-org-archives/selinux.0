Message-Id: <200207271043.KAA05992@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: run_init
Date: Sat, 27 Jul 2002 12:45:02 +0200
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

The run_init program on my SuSE need follow rule 
allow run_init_t initrc_exec_t:file { execute };
to correct.
I think it should need this rule. After this I read rule set and found
this
# Execute the init scripts
domain_auto_trans(run_init_t, etc_t, initrc_t)

Now my question: 
The init scripts are labled with initrc_exec_t and so etc_t should be 
initrc_exec_t to run correct. Or?

Thanks

  Carsten

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
