Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h422USI4014192
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 22:30:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h422UH7R020176
	for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 02:30:17 GMT
Received: from web20803.mail.yahoo.com (web20803.mail.yahoo.com [216.136.226.192])
        by jazzband.ncsc.mil  with SMTP id h422UGKP020173 for <selinux@tycho.nsa.gov>; Fri, 2 May 2003 02:30:16 GMT
Message-ID: <20030502023006.87948.qmail@web20803.mail.yahoo.com>
Date: Thu, 1 May 2003 19:30:06 -0700 (PDT)
From: Akshay Gangam <gvakshay@yahoo.com>
Subject: A small addition to Makefile
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200304261853.55786.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1214715125-1051842606=:87765"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1214715125-1051842606=:87765
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Can these changes be ported to the tree.

The changes to, the Makefile at selinux directory are
:

1) clean  2) mrproper  and  3) distclean 

The diff is :

[root@vriksha selinux]# diff Makefile Makefile.old
43,65d42
<
< clean:
<       @echo "Cleaning the SELinux kernel."
<       cd ../lsm$(LSMVER) && make clean
<       cd module && make clean
<       cd tools && make clean
<       cd policy && make clean
<       cd libsecure && make clean
<       cd selopt && make clean
<       cd setfiles && make clean
<       cd policy && make clean
<       @echo "Done."
<
< mrproper:clean
<       @echo "mrproper of SELinux kernel."
<       cd ../lsm$(LSMVER) && make mrproper
<       @echo "Done."
<
< distclean:mrproper
<       @echo "distclean of SELinux kernel"
<       cd ../lsm$(LSMVER) && make distclean
<       cd selopt && make distclean
<       @echo "Done."

=====
Akshay R Gangam 

"A mathematician is a device for turning coffee into theorems."
    - Paul Erdos

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
--0-1214715125-1051842606=:87765
Content-Type: application/x-tar; name="Makefile.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: Makefile.tar.gz
Content-Disposition: attachment; filename="Makefile.tar.gz"

H4sICGbXsT4AA01ha2VmaWxlLnRhcgDtVttOGzEQzSv5iimqoH3IhRCoRFSp
lOYBNbSU0EpVVaHFO0ssvPbWF0H+vvZeyS40LBKqkHxest6ZOWc8M2vnJLjG
iDLsPCOGO8Ph/njcGWao/473R/b53f7eeHdvd+ze7+yMRnsdGD5nUgWM0oEE
6Egh9L/81tlfKGbzkx/Ts/e9UX/c7QaMHXQ3PiBZCNj8KQzEtjqAtwmjhGq2
BJUgodEStv8YSq4pt7VjbLu/WQZ9RFBGImgBEoMQ9ALh2/fjo89w/GV+fjib
gQuShmgquLKL1ONsevjpZAoRlUpbsq71QamrVE4DTRaUX6XONmPQEtGpkhBi
ERqGsLUFsR1lyEIh39brN9nD243uhhaGLHJ7t3t3AwfF20LvSPCIXhlZSM6n
M8rNLVyj5Mhy4X5/wFRcKpQZxMgNSQmgKouhLHwSW4hJ+VwqpFtWJftxto02
/JOyWi5yssJ7kb9tZh/wsAhxS2WSRNhiu/NDAUcMMYTLZZqEsQVlzp+IOBEc
uVYPNszxNTq2Vt2pJMJO5hJI3q/ATVUuo4VgqjYWvcw/teehtTR6ShJ47P4Z
vVRI7LjnkuW6zvqovdi60IjaCoYBxu7jcD7OwPEGhKzsRlNGNcWioG6tniRp
J+Xr6XlGkJMpZCLRJVu9K61limFM2/FAZ1aIasMcJO7wSRvr2qzxVq+2O5s+
lz2N4Be8gl4EA9RkkLaC6uUgxCgwTF/k4Qp+Txw1L0evF4O9nrIyDKxgxt+M
W6GdWOH1mnqZYFu9NKaFFuVUS1Kk+Vi1WlQLvSRQ6iZsq1eLaqGnFkEobtrq
1aLu0WsOnEJdTlP6LWTLB2d1jloXg+o8oRAoRrVgqh02Ei11yfLJHo/u1iMM
A15dekdu+aQ7IyW676ytDKvfYPW+lmhlaJ5tla12Ztw11Aq4TqhWkVgmUiQo
D1bNxWsQUcurOQ9sCIVU6az8DZfS1FRbc3MXgffV6I5xNZX//X/Qw8PDw8PD
w8PDw8PDw8PDw8PDw8PDw8PDw8Pj5eIv+P7vdgAoAAA=

--0-1214715125-1051842606=:87765--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
