Message-ID: <4F567572.5060705@rubix.com>
Date: Tue, 06 Mar 2012 21:37:06 +0100
From: Andy Warner <warner@rubix.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Login context for a VNC connection
Content-Type: multipart/alternative;
 boundary="------------060508040301030300080401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060508040301030300080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am trying to configure the login context for a user connection through 
Tiger VNC. I am using RHEL6 with the MLS policy, fully updated. 
Currently I am getting:

system_u:system_r:initrc_t:SystemLow-SystemHigh

This does not seem correct. Can someone please give me information on 
hos this context is calculated and how I can configure it so the user 
receives a context of my choosing.

Thanks,

Andy Warner

--------------060508040301030300080401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <font face="Arial">I am trying to configure the login context for a
      user connection through Tiger VNC. I am using RHEL6 with the MLS
      policy, fully updated. Currently I am getting:<br>
      <br>
      system_u:system_r:initrc_t:SystemLow-SystemHigh<br>
      <br>
      This does not seem correct. Can someone please give me information
      on hos this context is calculated and how I can configure it so
      the user receives a context of my choosing. <br>
      <br>
      Thanks,<br>
      <br>
      Andy Warner<br>
    </font>
  </body>
</html>

--------------060508040301030300080401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
