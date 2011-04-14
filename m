Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3EG7GvD015340
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2011 12:07:16 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3EG7F5F015085
	for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2011 16:07:15 GMT
Received: by iyb26 with SMTP id 26so1902336iyb.12
        for <selinux@tycho.nsa.gov>; Thu, 14 Apr 2011 09:07:15 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 14 Apr 2011 09:07:15 -0700
Message-ID: <BANLkTi=owF5uDftV12_ujGU=wWiKkG8M2w@mail.gmail.com>
Subject: Generating policy for embedded platforms.
From: Sam Gandhi <samgandhi9@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Hopefully this is appropriate mailing list for this type of email, if
not please do let what is the appropriate forum for questions below.

I am trying to enable SELinux on a embedded platform running linux 2.6.35.

One of the idea we have is to run seLinux is permissive mode and
gather the AVC messages as our programs start and convert those
messages to 'allow' policy and deny everything else, much like what is
done in IP packet forwarding, allow only traffic you know you want to
process and deny everything else.

Now the question are: is how does one generate deny-all policy for SELinux?

I have come across mdp program in kernel source code and
install_policy.sh script is that the right way to get started on
building the most minimum policy set for embedded system, where large
desktop policy may not be appropriate?

Below is the script I am trying to use to setup the dummy policy (as
described in Documentation/SELinux.txt), and booting kernel with
enforcing=0 selinux=1 kernel parameters.

problem is I don't see any of the avc messages as my applications
start and open files/sockets etc. What am I doing wrong?


cd /tmp/
VERS=`checkpolicy -V  | awk '{print $1}'`
/bin/mdp policy.conf file_contexts
checkpolicy -o policy.$VERS policy.conf
mkdir -p /etc/selinux/dummy/policy
mkdir -p /etc/selinux/dummy/contexts/files
cp file_contexts /etc/selinux/dummy/contexts/files
cp policy.$VERS /etc/selinux/dummy/policy
echo "user system_u roles system_r;" >> /etc/selinux/dummy/policy/users
echo "user root roles { staff_r sysadm_r };" >>
/etc/selinux/dummy/policy/users
cat > /etc/selinux/config << EOF
SELINUX=permissive
SELINUXTYPE=dummy
EOF

Sam

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
