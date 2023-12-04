Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qeg1Ue1p"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3581B0
	for <selinux@vger.kernel.org>; Mon,  4 Dec 2023 08:16:59 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40838915cecso47307795e9.2
        for <selinux@vger.kernel.org>; Mon, 04 Dec 2023 08:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706618; x=1702311418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGkB7N2M3XF3Wpiw933wcn4pnUQOl5+QTxSO+fWlDeI=;
        b=Qeg1Ue1paS7cNWa7ibWjHXVuNtkOPcKMUPQzJ6HLH2rN/psHBDIz9zlqWZSgLZ6kjM
         YoaQTQcx6LsLBllrUahzhqwWTtUAoAXQFPdCcwZ+HaVqncYaIhq/iKtgrcyLeGbBC/VE
         Zd2FJSDKTylS5y+hKaUxeBUEN//boKb/uN9+/iiqAMOVhKk7TQ6XggtwGqaOKNEJ/igI
         jw6PXJenA+iuB5cq4/Ofy9R380pnJD2WRJwYtpPuSosfE77l308WtGB0rkH1rEStkWO1
         YFZ/Ym3cnQtHDvLK5BrFHZshec6G8Uob4zHZ0Of4JD1zSWiUwsWI5AVYIZFzRIW8ETlX
         MEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706618; x=1702311418;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGkB7N2M3XF3Wpiw933wcn4pnUQOl5+QTxSO+fWlDeI=;
        b=WdM4ZtZEq/ND48i1IP6XP6niCKHQyxdT1S1wF06x08H3RbDhb4fn+FNUMT+stHr4gx
         nsCEGu/3keGwsCfS7FdeJBRs5YiLg5qK02pp2PQbd4FBd+75NntBPhI9QGiytrb/QZB9
         BJpxmuqkBn07/fKUW7bMxlIMPqAe8l+LxoZYfckknHEz15YiE4xu8ml4JzJ+HHs9524Q
         KYcdTgvFAksQz650vSP4UMGN8EHykYPjx7tVbTt636ElTISQ0JE8wZD8xtOqqm+iVbPA
         i9bVsB3jo6EpWfDxx0eVtyCSGhNX1fPH4K2KVYv4+GoGhbhsayVzyLG7lMMLOcEeEJL/
         9Jnw==
X-Gm-Message-State: AOJu0YwcYWFlkOoxb1ya79ngAn/TQaM7FN+F04TnAcZmVa0HHI0XjAnj
	x50RiwIarUwk4R/2nBd2vq2lNGPe/Ug=
X-Google-Smtp-Source: AGHT+IH3aLgRDh22tN4fDdKpjPg7f1gu5wY3Y6qg89ApDq1w+CItxPEwUr6V6p/iWLweyKzt2Sqfbg==
X-Received: by 2002:a05:600c:474a:b0:40b:5e1c:af31 with SMTP id w10-20020a05600c474a00b0040b5e1caf31mr2676783wmo.55.1701706617924;
        Mon, 04 Dec 2023 08:16:57 -0800 (PST)
Received: from nz.home (host86-139-202-110.range86-139.btcentralplus.com. [86.139.202.110])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d490d000000b0033333ebd106sm8834892wrq.75.2023.12.04.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:16:57 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id E372D13803FE12; Mon,  4 Dec 2023 16:16:56 +0000 (GMT)
From: Sergei Trofimovich <slyich@gmail.com>
To: selinux@vger.kernel.org
Cc: Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH] libsemanage: fix src/genhomedircon.c build on `gcc-14` (`-Werror=alloc-size`)
Date: Mon,  4 Dec 2023 16:16:55 +0000
Message-ID: <20231204161655.1349063-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`gcc-14` added a new `-Walloc-size` warning that makes sure that size of
an individual element matches size of a pointed type:

    https://gcc.gnu.org/PR71219

`libsemanage` triggers it on `calloc()` calls where member size is used
as `1` (instead of member count):

    genhomedircon.c: In function 'ignore_setup':
    genhomedircon.c:152:21:
      error: allocation of insufficient size '1' for type 'ignoredir_t'
        {aka 'struct IgnoreDir'} with size '16' [-Werror=alloc-size]
      152 |                 ptr = calloc(sizeof(ignoredir_t),1);
          |                     ^

Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 libsemanage/src/genhomedircon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 8f8774d3..66585987 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -149,7 +149,7 @@ static int ignore_setup(char *ignoredirs) {
 
 	tok = strtok(ignoredirs, ";");
 	while(tok) {
-		ptr = calloc(sizeof(ignoredir_t),1);
+		ptr = calloc(1, sizeof(ignoredir_t));
 		if (!ptr)
 			goto err;
 		ptr->dir = strdup(tok);
-- 
2.42.0

