Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3BFr3BW029765
	for <selinux@tycho.nsa.gov>; Thu, 11 Apr 2013 11:53:03 -0400
References: 
Message-ID: <1365695580.32085.YahooMailNeo@web163401.mail.gq1.yahoo.com>
Date: Thu, 11 Apr 2013 08:53:00 -0700 (PDT)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: sysadm restarting services
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="-1278017997-1090892589-1365695580=:32085"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

---1278017997-1090892589-1365695580=:32085
Content-Type: text/plain; charset=us-ascii

Hello,

I trying to grant sysadm permissions to restart a service. The service needs to run as it's own type, preferably using system_r role. I'm running Red Hat 6.3 with a custom policy based on the reference policy.

>From the research I've done so far, it appears that I can use 'run_init' or enable the 'direct_sysadm_daemon' flag when I compile the policy. However, using the 'direct_sysadm_daemon' flag doesn't seem to allow sysadm to restart the service. Instead, it seems to allow sysadm access to execute the program the service is pointing to since the daemon attribute is being added in the 'init_daemon_domain' template call. I need sysadm to make the call through the service script since the service has some additional logic for launching the executable.


My module types are as follows (I modeled this after other services like ntp, dhcp, etc.) :

# Service: /etc/init.d/myprog
type myprog_initrc_exec_t;
init_script_file( myprog_initrc_exec_t )

# Main Program: /usr/sbin/myprog

type myprog_t;
type myprog_exec_t; 

init_daemon_domain( myprog_t, myprog_exec_t )



What is the best/recommended way for sysadm to restart services (run_init vs. direct)?



Thanks,
Andy Ruch

---1278017997-1090892589-1365695580=:32085
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:times new roman, new york, times, serif;font-size:12pt"><div id="yiv417125557"><div><div style="color:#000;background-color:#fff;font-family:times new roman, new york, times, serif;font-size:12pt;"><div id="yiv417125557yui_3_7_2_20_1365606203797_39">Hello,</div><div id="yiv417125557yui_3_7_2_20_1365606203797_56"><br></div><div style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;" id="yiv417125557yui_3_7_2_20_1365606203797_58">I trying to grant sysadm permissions to restart a service. The service needs to run as it's own type, preferably using system_r role. I'm running Red Hat 6.3 with a custom policy based on the reference policy.</div><div id="yiv417125557yui_3_7_2_20_1365606203797_130" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times,
 serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_135"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_132" style="color:rgb(0, 0,
 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">From the research I've done so far, it appears that I can use 'run_init' or enable the 'direct_sysadm_daemon' flag when I compile the policy. However, using the 'direct_sysadm_daemon' flag doesn't seem to allow sysadm to restart the service. Instead, it seems to allow sysadm access to execute the program the service is pointing to since the daemon attribute is being added in the 'init_daemon_domain' template call. I need sysadm to make the call through the service script since the service has some additional logic for launching the executable.<br id="yiv417125557yui_3_7_2_20_1365606203797_262"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_259" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br
 id="yiv417125557yui_3_7_2_20_1365606203797_266"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_263" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">My module types are as follows (I modeled this after other services like ntp, dhcp, etc.) :</div><div id="yiv417125557yui_3_7_2_20_1365606203797_177" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_184"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_181" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"># Service: /etc/init.d/myprog</div><div id="yiv417125557yui_3_7_2_20_1365606203797_205" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york,
 times, serif;background-color:transparent;font-style:normal;">type myprog_initrc_exec_t;</div><div id="yiv417125557yui_3_7_2_20_1365606203797_222" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">init_script_file( myprog_initrc_exec_t )</div><div id="yiv417125557yui_3_7_2_20_1365606203797_209" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_214"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_211" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"># Main Program: /usr/sbin/myprog<br></div><div id="yiv417125557yui_3_7_2_20_1365606203797_219" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times,
 serif;background-color:transparent;font-style:normal;">type myprog_t;</div><div id="yiv417125557yui_3_7_2_20_1365606203797_219" style="color:rgb(0,
 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">type myprog_exec_t; <br id="yiv417125557yui_3_7_2_20_1365606203797_255"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_252" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">init_daemon_domain( myprog_t, myprog_exec_t )</div><div id="yiv417125557yui_3_7_2_20_1365606203797_268" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_273"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_270" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br></div><div id="yiv417125557yui_3_7_2_20_1365606203797_310"
 style="color:rgb(0, 0, 0);font-size:16px;
font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_317"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_314" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">What is the best/recommended way for sysadm to restart services (run_init vs. direct)?</div><div id="yiv417125557yui_3_7_2_20_1365606203797_362" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_367"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_374" style="
color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_379"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_376" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"><br id="yiv417125557yui_3_7_2_20_1365606203797_383"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_380" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">Thanks,</div><div id="yiv417125557yui_3_7_2_20_1365606203797_387" style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;">Andy Ruch<br id="yiv417125557yui_3_7_2_20_1365606203797_299"></div><div id="yiv417125557yui_3_7_2_20_1365606203797_241"
 style="color:rgb(0, 0, 0);font-size:16px;font-family:times new roman, new york, times, serif;background-color:transparent;font-style:normal;"> </div></div></div></div></div></body></html>
---1278017997-1090892589-1365695580=:32085--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
