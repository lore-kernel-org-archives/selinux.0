Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAKAkYRb022824
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 05:46:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAKAkXqY017392
	for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 10:46:33 GMT
Received: from baitaca.ipen.br (baitaca.ipen.br [200.136.52.8])
        by jazzband.ncsc.mil  with ESMTP id hAKAkW0o017389 for <selinux@tycho.nsa.gov>; Thu, 20 Nov 2003 10:46:32 GMT
Message-ID: <3FBC9B4A.30504@ipen.br>
Date: Thu, 20 Nov 2003 08:45:30 -0200
From: =?ISO-8859-1?Q?Carlos_An=EDsio_Monteiro?= <monteiro@ipen.br>
MIME-Version: 1.0
To: Russell Coker <russell@coker.com.au>, selinux <selinux@tycho.nsa.gov>
Subject: initrd image
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

You sent a email to selinux list saying that ceased the use of the initrd.
Please, I'd like to know, how you are loading first policy to running 
before the init process. Because, if I load policy after the init 
process one inconsistency is verified and, in my case, I not succeeded 
in login to the system, due selinux not acknowledge the context default 
for the users.

Thanks.

-- 
Carlos Anisio Monteiro  <monteiro@ipen.br>
IPEN/CNEN-SP
Sao Paulo - Brasil



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
