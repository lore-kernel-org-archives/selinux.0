Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1R4OlYD010788
 for <selinux@tycho.nsa.gov>; Sun, 26 Feb 2017 23:24:47 -0500
Received: from www.coker.com.au (58-7-132-63.dyn.iinet.net.au [58.7.132.63])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: russell@coker.com.au)
 by smtp.sws.net.au (Postfix) with ESMTPSA id B6215ECC2
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:24:38 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: strange audit2allow error
Date: Mon, 27 Feb 2017 15:24:37 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201702271524.37975.russell@coker.com.au>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

# audit2allow -l < /var/log/audit/audit.log -R

require {
        type devicekit_power_t;
}

#============= devicekit_power_t ==============
devicekit_dbus_chat_power(devicekit_power_t)
# audit2allow -l < /var/log/audit/audit.log 


#============= devicekit_power_t ==============
allow devicekit_power_t dpkg_script_t:dbus send_msg;

Above is the output of audit2allow.  For some reason audit2allow -R is 
generating the wrong parameter for devicekit_dbus_chat_power().

Here is the interface in question:

########################################
## <summary>
##      Send and receive messages from
##      devicekit power over dbus.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`devicekit_dbus_chat_power',`
        gen_require(`
                type devicekit_power_t;
                class dbus send_msg;
        ')

        allow $1 devicekit_power_t:dbus send_msg;
        allow devicekit_power_t $1:dbus send_msg;
')

Any ideas on how to debug this?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
