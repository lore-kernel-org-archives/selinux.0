Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1EKlXlR011750
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 15:47:33 -0500
Received: from el-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1EKlWrZ023870
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 20:47:32 GMT
Received: by el-out-1112.google.com with SMTP id j27so488984elf.0
        for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 12:47:31 -0800 (PST)
Message-ID: <dd18b0c30802141247v2d54b5fej5780e2ab6fe665cb@mail.gmail.com>
Date: Thu, 14 Feb 2008 20:47:30 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: selinux@tycho.nsa.gov
Subject: pommed
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3045_12463908.1203022050136"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_3045_12463908.1203022050136
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; I seem to have noticed something with pommed daemon, causing my
screen dimmer to not work as well as the keyboard ambient lights, the
messages I see are these
cat /var/log/daemon.log =

pommed[2771]: DBus system bus connection failed: An SELinux policy prevents
this sender from sending this message to this recipient (rejected message
had interface
"org.freedesktop.DBus" member "Hello" error name "(unset)" destination "
org.freedesktop.DBus")

pommed[1865]: DBus system bus connection failed: Failed to connect to socket
/var/run/dbus/system_bus_socket: No such file or directory

pommed[1864]: Could not open /sys/class/leds/smc::kbd_backlight/brightness:
No such file or directory

(Interesting part is these two files brightness and system_bus_socket do
exsist)

I've issued make clean && make enableaudit && make policy
 to acquire as  many avc's as possible  but am still receiving this error,
any help;
                --Justin P. Mattock

------=_Part_3045_12463908.1203022050136
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello; I seem to have noticed something with pommed daemon, causing my screen dimmer to not work as well as the keyboard ambient lights, the messages I see are these <br>cat /var/log/daemon.log =<br><br>pommed[2771]: DBus system bus connection failed: An SELinux policy prevents this sender from sending this message to this recipient (rejected message had interface <br>
&quot;org.freedesktop.DBus&quot; member &quot;Hello&quot; error name &quot;(unset)&quot; destination &quot;org.freedesktop.DBus&quot;)<br><br>pommed[1865]: DBus system bus connection failed: Failed to connect to socket /var/run/dbus/system_bus_socket: No such file or directory<br>
<br>pommed[1864]: Could not open /sys/class/leds/smc::kbd_backlight/brightness: No such file or directory&nbsp; <br><br>(Interesting part is these two files brightness and system_bus_socket do exsist)<br><br>I&#39;ve issued make clean &amp;&amp; make enableaudit &amp;&amp; make policy <br>
&nbsp;to acquire as&nbsp; many avc&#39;s as possible&nbsp; but am still receiving this error, <br>any help;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --Justin P. Mattock<br>

------=_Part_3045_12463908.1203022050136--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
