Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A40AC07E85
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118522082F
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 09:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118522082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeLKJzc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:55:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbeLKJzc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 11 Dec 2018 04:55:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D4AC307CDD6;
        Tue, 11 Dec 2018 09:55:31 +0000 (UTC)
Received: from workstation (unknown [10.43.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88F825C1B4;
        Tue, 11 Dec 2018 09:55:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 1/2] python/chcat: improve the code readability
References: <20181209142323.21149-1-nicolas.iooss@m4x.org>
Date:   Tue, 11 Dec 2018 10:55:28 +0100
In-Reply-To: <20181209142323.21149-1-nicolas.iooss@m4x.org> (Nicolas Iooss's
        message of "Sun, 9 Dec 2018 15:23:22 +0100")
Message-ID: <pjdftv4e6b3.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 11 Dec 2018 09:55:31 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> flake8 reports many warnings for chcat:
>
>     chcat:7:1: E265 block comment should start with '# '
>     chcat:29:1: F401 'string' imported but unused
>     chcat:44:1: E722 do not use bare 'except'
>     chcat:104:9: F841 local variable 'e' is assigned to but never used
>     chcat:144:9: F841 local variable 'e' is assigned to but never used
>     chcat:186:9: F841 local variable 'e' is assigned to but never used
>     chcat:234:9: F841 local variable 'e' is assigned to but never used
>     chcat:262:9: F841 local variable 'e' is assigned to but never used
>     chcat:281:5: F841 local variable 'e' is assigned to but never used
>     chcat:385:9: E722 do not use bare 'except'
>     chcat:402:1: E305 expected 2 blank lines after class or function definition, found 1
>     chcat:436:5: F841 local variable 'e' is assigned to but never used
>
> Fix all of them.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
> This patch needs to be applied after "python/chcat: use check_call instead of getstatusoutput",
> https://lore.kernel.org/selinux/CAJfZ7=k+dNFE7AOO_FJhSMZP7WdvkJf3zbfqeY6kSkabOm+Uag@mail.gmail.com/T/#e720d3de77d336300faf6cc3d8a2940b70c9a169a
>
>  python/chcat/chcat | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/python/chcat/chcat b/python/chcat/chcat
> index 1de92306e963..73f757258807 100755
> --- a/python/chcat/chcat
> +++ b/python/chcat/chcat
> @@ -4,7 +4,7 @@
>  #
>  #    chcat is a script that allows you modify the Security label on a file
>  #
> -#`   Author: Daniel Walsh <dwalsh@redhat.com>
> +#    Author: Daniel Walsh <dwalsh@redhat.com>
>  #
>  #    This program is free software; you can redistribute it and/or
>  #    modify it under the terms of the GNU General Public License as
> @@ -26,7 +26,6 @@ import subprocess
>  import sys
>  import os
>  import pwd
> -import string
>  import getopt
>  import selinux
>  import seobject
> @@ -41,7 +40,7 @@ try:
>                      localedir="/usr/share/locale",
>                      codeset='utf-8',
>                      **kwargs)
> -except:
> +except ImportError:
>      try:
>          import builtins
>          builtins.__dict__['_'] = str
> @@ -101,7 +100,7 @@ def chcat_user_add(newcat, users):
>              cmd = ["semanage", "login", "-m", "-r", new_serange, "-s", user[0], u]
>          try:
>              subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
> -        except subprocess.CalledProcessError as e:
> +        except subprocess.CalledProcessError:
>              errors += 1
>  
>      return errors
> @@ -141,7 +140,7 @@ def chcat_add(orig, newcat, objects, login_ind):
>          cmd = ["chcon", "-l", "%s:%s" % (sensitivity, cat_string), f]
>          try:
>              subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
> -        except subprocess.CalledProcessError as e:
> +        except subprocess.CalledProcessError:
>              errors += 1
>      return errors
>  
> @@ -183,7 +182,7 @@ def chcat_user_remove(newcat, users):
>  
>          try:
>              subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
> -        except subprocess.CalledProcessError as e:
> +        except subprocess.CalledProcessError:
>              errors += 1
>  
>      return errors
> @@ -231,7 +230,7 @@ def chcat_remove(orig, newcat, objects, login_ind):
>          cmd = ["chcon", "-l", new_serange, f]
>          try:
>              subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
> -        except subprocess.CalledProcessError as e:
> +        except subprocess.CalledProcessError:
>              errors += 1
>      return errors
>  
> @@ -259,7 +258,7 @@ def chcat_user_replace(newcat, users):
>              cmd = ["semanage", "login", "-m", "-r", new_serange, "-s", user[0], u]
>          try:
>              subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
> -        except subprocess.CalledProcessError as e:
> +        except subprocess.CalledProcessError:
>              errors += 1
>      return errors
>  
> @@ -268,6 +267,7 @@ def chcat_replace(newcat, objects, login_ind):
>      if login_ind == 1:
>          return chcat_user_replace(newcat, objects)
>      errors = 0
> +    # newcat[0] is the sensitivity level, newcat[1:] are the categories
>      if len(newcat) == 1:
>          new_serange = newcat[0]
>      else:
> @@ -278,7 +278,7 @@ def chcat_replace(newcat, objects, login_ind):
>      cmd = ["chcon", "-l", new_serange] + objects
>      try:
>          subprocess.check_call(cmd, stderr=subprocess.STDOUT, shell=False)
> -    except subprocess.CalledProcessError as e:
> +    except subprocess.CalledProcessError:
>          errors += 1
>  
>      return errors
> @@ -382,7 +382,7 @@ def listusercats(users):
>      if len(users) == 0:
>          try:
>              users.append(os.getlogin())
> -        except:
> +        except OSError:
>              users.append(pwd.getpwuid(os.getuid()).pw_name)
>  
>      verify_users(users)
> @@ -399,6 +399,7 @@ def error(msg):
>      print("%s: %s" % (sys.argv[0], msg))
>      sys.exit(1)
>  
> +
>  if __name__ == '__main__':
>      if selinux.is_selinux_mls_enabled() != 1:
>          error("Requires a mls enabled system")
> @@ -433,7 +434,7 @@ if __name__ == '__main__':
>      except getopt.error as error:
>          errorExit(_("Options Error %s ") % error.msg)
>  
> -    except ValueError as e:
> +    except ValueError:
>          usage()
>  
>      if delete_ind:
