MIME-Version: 1.0
Date: Mon, 6 Aug 2012 16:17:14 -0700
Message-ID: <CAO-4OdGTUMZxOyjsF3wbtGXwV4W3=j5N3A7MnTWh2jm0te-S8Q@mail.gmail.com>
Subject: Don't audit debugfs
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: multipart/alternative; boundary=f46d04089131fdc69804c6a113c0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d04089131fdc69804c6a113c0
Content-Type: text/plain; charset=ISO-8859-1

Hi, all

Could we apply the following policy in android-4.1.1?

dontaudit domain debugfs:file {write open}

The reason is that if you want to debug using adb shell dmesg or cat
/proc/kmsg, you have to open --> write trace_marker to debug frame buffers.

Could you give some options? Thanks.....

-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d04089131fdc69804c6a113c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, all<div><br></div><div>Could we apply the following policy in android-4=
.1.1?</div><div><br></div><div>dontaudit domain debugfs:file {write open}</=
div><div><br></div><div>The reason is that if you want to debug using adb s=
hell dmesg or cat /proc/kmsg, you have to open --&gt; write trace_marker to=
 debug frame buffers.</div>
<div><br></div><div>Could you give some options? Thanks..... =A0</div><div>=
<div><br></div>-- <br><div>-----------------------------------</div>Haiqing=
 Jiang, PH.D student<div><br></div><div>Computer Science Department, North =
Carolina State University<br>
<div><br></div></div><br>
</div>

--f46d04089131fdc69804c6a113c0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
